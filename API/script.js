const url =
  "https://apis.data.go.kr/B551011/GoCamping/basedList?serviceKey=11f7d736a05b673007597162c81c5c1ffdecf6818e135a50188e95c9e435b1df&numOfRows=4000&pageNo=1&MobileOS=ETC&MobileApp=gocamping&_type=json";

fetch(url)
  .then((response) => response.json())
  .then((result) => {
    const data = result.response.body.items.item;

    const showPosition = (position) => {
      const latitude = position.coords.latitude;
      const longitude = position.coords.longitude;

      var container = document.getElementById("map");

      var options = {
        center: new kakao.maps.LatLng(latitude, longitude),
        level: 3,
      };

      var map = new kakao.maps.Map(container, options);

      var clusterer = new kakao.maps.MarkerClusterer({
        map: map,
        averageCenter: true,
        minLevel: 10,
      });

      var markers = [];

      for (let i = 0; i < data.length; i++) {
        var marker = new kakao.maps.Marker({
          map: map,
          position: new kakao.maps.LatLng(data[i].mapY, data[i].mapX),
        });

        markers.push(marker);

        var infowindow = new kakao.maps.InfoWindow({
          content: data[i].facltNm,
        });

        // 이벤트 함수 (마우스를 오버했을 때, 실행되는 함수)
        function makeOverListener(map, marker, infowindow) {
          return function () {
            infowindow.open(map, marker);
          };
        }

        // 이벤트 함수 (마우스를 아웃했을 때, 실행되는 함수)
        function makeOutListener(infowindow) {
          return function () {
            infowindow.close();
          };
        }

        kakao.maps.event.addListener(
          marker,
          "mouseover",
          makeOverListener(map, marker, infowindow),
        );

        kakao.maps.event.addListener(
          marker,
          "mouseout",
          makeOutListener(infowindow),
        );
      }

      clusterer.addMarkers(markers);
    };

    const errorPosition = (err) => {
      alert(err.message);
    };

    window.navigator.geolocation.getCurrentPosition(
      showPosition,
      errorPosition,
    );
  });
