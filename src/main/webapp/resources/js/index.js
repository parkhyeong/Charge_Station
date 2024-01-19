/**
 * index
 */
let indexJs = function() {
	"use strict";
	
	let csFastCnt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	let csSlowCnt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	let csTotalCnt = 0;
	let feeData = [];
	let feeSlowData = [];
	let feeFastData = [];
	let feeSlowSwiper, feeFastSwiper;

	function _init() {
		_initEvent();
		_clickEvent();
	}
	
	function _initEvent(){
		$('#feeSlowSwiper').hover(
			function(){
				feeSlowSwiper.autoplay.stop();
			},function(){
				feeSlowSwiper.autoplay.start();
			}
		)
		$('#feeFastSwiper').hover(
			function(){
				feeFastSwiper.autoplay.stop();
			},function(){
				feeFastSwiper.autoplay.start();
			}
		)

		_getEvCs();
		_getComList();
		_getNotiPopup();
	}
	
	function _clickEvent(){
		$('#chargerCnt').click(function(){
			self.location = _ctx + "/front/chargePoint/search?" + 'current_position';
		});

		$('#bidList').click(function(){
			self.location = _ctx + "/front/fee/feeTable";
		});
		
		
		$('#csFee').click(function(){
			self.location = _ctx + "/front/fee/compare";
		});
		
		$('#statistics').click(function(){
			self.location = _ctx + "/front/statistics/evCar";
		});

		// 지도에서 지역이름 클릭 시 충전소조회 페이지로 이동
		$('.mvSearch').click(function(){
			let regionId = $(this).attr("id");
			self.location = _ctx + "/front/chargePoint/search?" + regionId;
		});

		$(".index-btnDC").click(function (){
			$("#feeSlowSwiper").hide();
			_displayFeeFast();
		});

		$(".index-btnAC").click(function (){
			$("#feeFastSwiper").hide();
			_displayFeeSlow();
		});
	}
	
	function _getComList(){		
		$.ajax({
			type: 'GET',
			url: _ctx + '/ws/organization/company/list',
			dataType: 'json',
			success: function(jsonData, textStatus, jqXHR) {
				for(let i = 0, len = jsonData.result.length; i < len; i++){
					let coLogoId = jsonData.result[i].coLogoId?jsonData.result[i].coLogoId:null;
					feeData.push({
						bid: jsonData.result[i].bid,
						name: jsonData.result[i].companyName,
						fastFee: 0,
						fastCount: 0,
						slowFee: 0,
						slowCount: 0,
						coLogoId: coLogoId
					})
				}
				_getFeeData();
			}
		});
	}
	
	function _getFeeData(){
		$.ajax({
			type: 'GET',
			url: _ctx + '/ws/tariff/charger/list',
			dataType: 'json',
			success: function(jsonData, textStatus, jqXHR) {
				for(let i = 0, len = jsonData.result.length; i < len; i++){
					if(jsonData.result[i].customerType != 'G'){
						for(let j = 0, size = feeData.length; j < size; j++){
							if(jsonData.result[i].bid == feeData[j].bid){
								if(jsonData.result[i].csKindType == '1'){
									feeData[j].slowFee += jsonData.result[i].averageFee;
									feeData[j].slowCount++;
								}else if(jsonData.result[i].csKindType == '2'){
									feeData[j].fastFee += jsonData.result[i].averageFee;
									feeData[j].fastCount++;
								}else{
									feeData[j].slowFee += jsonData.result[i].averageFee;
									feeData[j].slowCount++;
									feeData[j].fastFee += jsonData.result[i].averageFee;
									feeData[j].fastCount++;
								}
								break;
							}							
						}
					}
				}
				_setFeeTable();
			}
		});
	}
	
	function _setFeeTable(){
		let html = '';
		for(let i = 0; i < feeData.length; i++){
			html += _getCompanyHtml(feeData[i], i);
			let temp = {};
			if(feeData[i].fastCount !== 0){
				temp = {
					name: feeData[i].name,
					fee: formatUtilsJs.roundTo2(feeData[i].fastFee / feeData[i].fastCount),
					coLogoId: feeData[i].coLogoId
				}
				feeFastData.push(temp);
			}
			if(feeData[i].slowCount !== 0){
				temp = {
					name: feeData[i].name,
					fee: formatUtilsJs.roundTo2(feeData[i].slowFee / feeData[i].slowCount),
					coLogoId: feeData[i].coLogoId
				}
				feeSlowData.push(temp);
			}
		}

		_displayFeeFast();
	}
	
	function _getCompanyHtml(comData, idx){
		let swiperChk = idx % 16;
		let flexChk = idx % 4;
		let html = '';
		if(swiperChk === 0){
			html += '<div class="swiper-slide">';
		}
		if(flexChk === 0){
			html += '<div class="flex" style="justify-content: space-around;">';
		}
		html += '<div class="com-box">';
		if(comData.coLogoId){
			html += '<div class="com-box-img" onclick="indexJs.gotoFeeTable('+ idx +')"><img src="' + _ctx + '/ws/file/download?id=' + comData.coLogoId + '"></div>';
		}else{
			html += '<div class="com-box-img" onclick="indexJs.gotoFeeTable('+ idx +')"></div>';
		}
		html += '<div class="com-box-name">' + comData.name + '</div>';
		html += '</div>';
		if(flexChk === 3){
			html += '</div>';
		}
		if(flexChk === 15){
			html += '</div>';
		}
		return html;
	}

	function _displayFeeFast(){
		_setFeeSwiper('feeFast');
		let auto = (feeFastData.length > 10);
		feeFastSwiper = new Swiper('#feeFastSwiper', {
			spaceBetween: 0,
			centeredSlides: false,
			slidesPerView: 1,
			loop: auto,
			autoplay: {
				delay: 1500,
				disableOnInteraction: true,
			},
			pagination: {
				el: '#feeFastPagination',
				clickable: true,
			}
	    });
	}
	
	function _displayFeeSlow(){
		_setFeeSwiper('feeSlow');
		let auto = feeSlowData.length > 10;
		feeSlowSwiper = new Swiper('#feeSlowSwiper', {
			spaceBetween: 0,
			centeredSlides: true,
			slidesPerView: 1,
			loop: auto,
			autoplay: {
				delay: 1500,
				disableOnInteraction: true,
			},
			pagination: {
				el: '#feeSlowPagination',
				clickable: true,
			}
	    });
	}

	function _setFeeSwiper(type){
		let arr = [];
		$("#feeSlowSwiper, #feeFastSwiper").empty();

		type === 'feeSlow' ? arr = feeSlowData : arr = feeFastData;

		let html = '<div class="swiper-wrapper" id="' + type + '"></div>';
		html += '<div class="swiper-pagination" id="' + type + 'Pagination"></div>';
		$("#" + type + "Swiper").append(html);

		html = '';
		for(let i = 0, len = arr.length; i < len; i++){
			let arrNameLen = arr[i].name.length;
			if((i % 10) === 0){
				html += '<div class="swiper-slide"><ul>';
			}
			if((i % 2) === 0){
				html += '<li class="flex">';
			}
			html += '<div class="fee-box">';
			html += '<div class="fee-box-img">';
			if(arr[i].coLogoId){
				html += '<img src="' + _ctx + '/ws/file/download?id=' + arr[i].coLogoId + '">';
			}
			html += '</div>';
			html += '<div>';
			if(arrNameLen > 12){
				let fontSize = 29 - arrNameLen;
				html += '<div class="fee-box-name font-' + fontSize + '">' + arr[i].name + '</div>';
			}else{
				html += '<div class="fee-box-name">' + arr[i].name + '</div>';
			}
			html += '<div class="fee-box-fee feeColor">' + arr[i].fee + '원/kWh</div>';
			html += '</div></div>';
			if((i % 2) === 1){
				html += '</li>';
			}
			if((i % 10) === 9){
				html += '</ul></div>';
			}
		}
		$("#" + type).append(html);

		if(type === 'feeSlow'){
			$(".feeColor").addClass('green');
			$("#feeSlowSwiper").fadeIn(500);
		}else{
			$(".feeColor").addClass('blue');
			$("#feeFastSwiper").fadeIn(500);
		}
	}
	
	function _getEvCs(){
		$.ajax({
			type: 'GET',
			url: _ctx + '/ws/statistics/cs/all',
			dataType: 'json',
			success: function(jsonData, textStatus, jqXHR) {
				for(let i = 0; i < 2; i++){
					if(jsonData.result[i].csType == 'CSTP02'){
						csSlowCnt[1] = jsonData.result[i].rgn11000;
						csSlowCnt[2] = jsonData.result[i].rgn26000;
						csSlowCnt[3] = jsonData.result[i].rgn27000;
						csSlowCnt[4] = jsonData.result[i].rgn28000;
						csSlowCnt[5] = jsonData.result[i].rgn29000;
						csSlowCnt[6] = jsonData.result[i].rgn30000;
						csSlowCnt[7] = jsonData.result[i].rgn31000;
						csSlowCnt[8] = jsonData.result[i].rgn36000;
						csSlowCnt[9] = jsonData.result[i].rgn41000;
						csSlowCnt[10] = jsonData.result[i].rgn42000;
						csSlowCnt[11] = jsonData.result[i].rgn43000;
						csSlowCnt[12] = jsonData.result[i].rgn44000;
						csSlowCnt[13] = jsonData.result[i].rgn45000;
						csSlowCnt[14] = jsonData.result[i].rgn46000;
						csSlowCnt[15] = jsonData.result[i].rgn47000;
						csSlowCnt[16] = jsonData.result[i].rgn48000;
						csSlowCnt[17] = jsonData.result[i].rgn50000;
						for(let i = 1, len = csSlowCnt.length; i < len; i++){
							csSlowCnt[0] += csSlowCnt[i];
						}
					}else{
						csFastCnt[1] = jsonData.result[i].rgn11000;
						csFastCnt[2] = jsonData.result[i].rgn26000;
						csFastCnt[3] = jsonData.result[i].rgn27000;
						csFastCnt[4] = jsonData.result[i].rgn28000;
						csFastCnt[5] = jsonData.result[i].rgn29000;
						csFastCnt[6] = jsonData.result[i].rgn30000;
						csFastCnt[7] = jsonData.result[i].rgn31000;
						csFastCnt[8] = jsonData.result[i].rgn36000;
						csFastCnt[9] = jsonData.result[i].rgn41000;
						csFastCnt[10] = jsonData.result[i].rgn42000;
						csFastCnt[11] = jsonData.result[i].rgn43000;
						csFastCnt[12] = jsonData.result[i].rgn44000;
						csFastCnt[13] = jsonData.result[i].rgn45000;
						csFastCnt[14] = jsonData.result[i].rgn46000;
						csFastCnt[15] = jsonData.result[i].rgn47000;
						csFastCnt[16] = jsonData.result[i].rgn48000;
						csFastCnt[17] = jsonData.result[i].rgn50000;
						for(let i = 1, len = csFastCnt.length; i < len; i++){
							csFastCnt[0] += csFastCnt[i];
						}
					}
				}
				csTotalCnt = csSlowCnt[0] + csFastCnt[0];
				setCsCnt();
			}
		});
	}
	
	function setCsCnt(){
		let fast = '', slow = '', area = '';
		for(let i = 0; i < 18 ; i++){
			fast = $('#fast' + i);
			slow = $('#slow' + i);
			area = $('#area' + i);
			let a = Number(fast.css('width').replace('px',''));
			let b = Number(slow.css('width').replace('px',''));

			$("#total0").html(csTotalCnt.toLocaleString());
			fast.html(csFastCnt[i].toLocaleString());
			if(i == 0){
				slow.html(csSlowCnt[i].toLocaleString());
			} else {
				slow.html(csSlowCnt[i].toLocaleString() + '<div class="ar"></div>');
			}

			let c = Number(fast.css('width').replace('px',''));
			let d = Number(slow.css('width').replace('px',''));
			let e = Number(slow.css('left').replace('px',''));
			let t = Number($('#total0').css('left').replace('px',''));

			slow.css('left',e+(c-a));

			let f = Number(area.css('left').replace('px',''));
			area.css('left',f-(d-b)-(c-a));

			if(i == 0) {
				$('#total0').css('left', t+(c-a)+(d-b));
			}
		}
	}

	function _gotoFeeTable(idx){
		self.location= _ctx + "/front/fee/feeTable?" + idx;
	}

	function _getNotiPopup() {
		let standDate = new Date();
		standDate = dateUtilsJs.dateFormat(standDate, 'YYYY-MM-DD');
		standDate = standDate.replace(/-/g, '');

		let params = '?popupYn=Y&standDate=' + standDate;
		$.ajax({
			type: 'GET',
			url: _ctx + '/ws/notice/list' + params,
			dataType: 'json',
			success: function(jsonData) {
				let top;
				let left = 0;
				if(jsonData.result) {
					let result = jsonData.result;
					for(let i = 0, length = result.length; i < length; i++) {
						if(_getCookie(result[i].id ) === 'N') {
							continue;
						}
						top = result[i].popUpLocationY;
						let x = result[i].popUpSizeX + 32;
						let y = result[i].popUpSizeY + 71 + 16;
						window.open(_ctx + "/front/cs/noti/popup/" + result[i].id , result[i].id,'location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width='+ x +',height=' + y + ', top=' + top + ', left=' + left);
						left += x;
					}
				}
			}
		});
	}

	function _getCookie(name){
		let value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
		return value ? value[2] : 'Y';
	}

	return {
		init: _init,
		gotoFeeTable: _gotoFeeTable,
	};
}();