/**
 *  ajax 기본적으로 공통으로 들어가는 함수
 */
 
function successMessage(msg) {
	Swal.fire({
		title: msg,
		icon: 'success'
	}).then( (result) => {
		location.reload();
	})
}

function errorMessage(msg) {
	Swal.fire({
		title: msg,
		icon: 'error'
	})
}

function changeDate(date) {
	date = new Date(parseInt(date));
	year=date.getFullYear();
	month=date.getMonth();
	day=date.getDate();
	hour=date.getHours();
	minute=date.getMinutes();
	strDate = 
		year+"-"+month+"-"+day+" "+hour+":"+minute;
	return strDate;
}