const getJSON = function(url, callback) {
  const xhr = new XMLHttpRequest();
  xhr.open('GET', url, true);
  xhr.responseType = 'json';
  xhr.onload = function() {
    const status = xhr.status;
    if(status === 200) {
      callback(null, xhr.response);
    } else {
      callback(status, xhr.response);
    }
  };
  xhr.send();
};

//현재 위치 불러오기
var lat="";
var lon="";
navigator.geolocation.getCurrentPosition(function(pos){
	console.log(pos);
	
	lat=Math.round(pos.coords.latitude,3);
	lon=Math.round(pos.coords.longitude,3);
})
var api="e94b45e623f0fe23460ab9298bc2271b";
//var url="https://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lon+"&appid="+api;
var url_ok="https://api.openweathermap.org/data/2.5/weather?q=seoul&appid="+api;

getJSON(url_ok,function(err, data) {
  if(err !== null) {
    alert('날씨를 불러올수 없습니다' + err);
  } else {
	  var main=data.weather[0].main;
	  var w_desc=data.weather[0].description;
	  var temp=Math.round(data.main.temp- 273.15); //섭씨계산
	  
	  $("#w-temp").text(temp+"°");
	  $("#w-desc").text(w_desc);
	  $("#w-img").attr("src", "http://openweathermap.org/img/w/" + data.weather[0].icon + ".png");
	  
	  if(temp>35 || temp<-10){
		  $("#w-comment").text("오늘은 쉬어요!");
	  }else{
		  if(main=="Clear"){
			  $("#w-comment").text("맑아서 산책하기 좋은 날씨에요!");
		  }else if(main=="Clouds"){
			  $("#w-comment").text("흐려서 산책하기 좋은 날씨에요!");
		  }else if(main=="Rain" || main=="Drizzle"){
			  $("#w-comment").text("비와도 산책할 수 있어요!");
		  }else if(main=="Snow"){
			  $("#w-comment").text("눈 보러가요!!!");
		  }else{
			  $("#w-comment").text("산책해요 멍멍")
		  }
		  
	  }
  }
  
});

