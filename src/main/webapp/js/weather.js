const API_KEY="e94b45e623f0fe23460ab9298bc2271b";

function onGeoOk(position) {
    const lat = position.coords.latitude;
    const lon = position.coords.longitude;
    const url = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&lang=kr&appid=${API_KEY}&units=metric`;
    
	fetch(url)
        .then(response => response.json())
        .then(data => {
	  console.log(lat,lon)
	  
	  const city=data.name;
	  const main=data.weather[0].main;
	  const desc=data.weather[0].description;
	  const temp=Math.round(data.main.temp);

	  $("#w-city").text(city);
	  $("#w-temp").text(temp+"°");
	  $("#w-desc").text(desc);
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
        });
}

function onGeoError() {
    alert("날씨를 제공할 위치를 찾을 수 없습니다.")
}

navigator.geolocation.getCurrentPosition(onGeoOk, onGeoError);