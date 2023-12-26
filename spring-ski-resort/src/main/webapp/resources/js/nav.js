window.onload = function () {

    setTimeout(() => document.getElementById("ski-navbar").style.opacity = 0.8, 5000)
    if (!(document.getElementById('maintext1'))) {
        document.getElementById("ski-navbar").style.opacity = 0.8;

    }
    load();
    memberAlarmSpread();
}


const timer = ms => new Promise(res => setTimeout(res, ms))
const timer2 = ms => new Promise(res => setTimeout(res, ms))
async function load() {
    for (let i = 0; ; i++) {
        if (i == 10) {
            i = 0;
        }
        weatherListSearch().then(weatherInfo => {

            /*
            regionNum; //지역번호
            weatherHighTemp; // 최고온도 (지원안함)
            weatherLowTemp; // 최저온도(지원안함)
            weatherTemp; // 현재기온
            weatherSkyStatus; // 하늘 상태 (1맑음 2구름조금 3구름많음 4흐림)
            weatherRainStatus; //강수형태 (0없음,1비,2눈/비,3눈,4소나기)
            weatherAmount; // 강수량
            weatherPer; //강수량
            weatherDate; // 마지막 갱신 날짜
            weatherTime;	// 마지막 갱신 시간
               0 홍천읍
               1 화촌면
               2 두촌면
               3 내촌면
               4 서석면
               5 영귀미면
               6 남면
               7 서면
               8 북방면
               9 내면
            */
            
            const weatherDate = weatherInfo[i].weatherDate.slice(0, 4) + "년" + weatherInfo[i].weatherDate.slice(4, 6) + "월" + weatherInfo[i].weatherDate.slice(6, 8) + "일";
            var week_array = new Array('일', '월', '화', '수', '목', '금', '토');
            var region_grand_child = new Array('홍천읍', '화촌면', '두촌면', '내촌면', '서석면', '영귀미면', '남면', '서면', '북방면', '내면');
            var today_num = new Date().getDay();
            const weatherTime = weatherInfo[i].weatherTime.slice(0, 2) + ":" + weatherInfo[i].weatherTime.slice(2, 4);
            let weatherStatus = weatherInfo[i].weatherRainStatus;
            let Temp = weatherInfo[i].weatherTemp;

            if (weatherStatus == "없음") {
                weatherStatus = weatherInfo[i].weatherSkyStatus;
            }
            let weathericon = "";
            if (weatherStatus == "맑음") {
                weathericon = "brightness-high";
            } else if (weatherStatus == "구름조금") {
                weathericon = "cloud-sun";
            } else if (weatherStatus == "구름많음") {
                weathericon = "cloud";
            } else if (weatherStatus == "흐림") {
                weathericon = "cloud-haze";
            } else if (weatherStatus == "비") {
                weathericon = "cloud-drizzle";
            } else if (weatherStatus == "눈/비") {
                weathericon = "cloud-sleet";
            } else if (weatherStatus == "소나기") {
                weathericon = "cloud-rain-heavy";
            } else {
                weathericon = "cloud-snow";
            }

            if (document.getElementById("wrapper")) {
                document.getElementById("innerItem2").innerHTML = "<span class='weather-area'>" + region_grand_child[i] + " 날씨</span><br><br>" + weatherDate + "[" + week_array[today_num] + "]" + weatherTime + "갱신";
                document.getElementById("innerItem3").innerHTML = '<i class="weathericon bi bi-' + weathericon + '"></i><span class="weather-info">' + weatherStatus + Temp + '°C' + '</span>';
                document.getElementById("innerItem1");
                document.getElementById("innerItem4");
            }
        });

        await timer(10000);
    }
}

//날씨정보 불러오기
async function weatherSearch() {

    try {
        const url = "/weather/default";
        const config = {
            method: 'get'
        };
        const resp = await fetch(url, config);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }

}

//날씨리스트 불러오기
async function weatherListSearch() {

    try {
        const url = "/weather/list";
        const config = {
            method: 'get'
        };
        const resp = await fetch(url, config);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }

}


const navLinks = document.querySelectorAll(".ski-nav-link");

navLinks.forEach(link => {
    link.addEventListener("mouseover", (e) => {
        e.target.querySelector("span").style.width = "80%";
    });

    link.addEventListener("mouseout", (e) => {
        e.target.querySelector("span").style.width = "0%";
    });

});



//alarm-board 스위치

let bellSwitch = 0;
if (document.getElementById("alarm-bell")) {
    document.getElementById("alarm-bell").addEventListener('click', () => {
        let board = document.getElementById('alarm-board');
        let boardtitle = document.getElementById('alarm-board-title');
        if (bellSwitch == 1) {
            board.style.height = '0px';
          
            bellSwitch = 0;
            setTimeout(()=>{  document.getElementById('alarm-spread').style.display="none"; board.style.color="transparent"; boardtitle.style.color="transparent";} ,200);

        } else if (bellSwitch == 0) {
            document.getElementById('alarm-spread').style.display="block";
            board.style.height = '400px';        
            bellSwitch = 1;
            board.style.color="white"; boardtitle.style.color="white";
        }
        document.getElementById('alarmTouch').style.display = 'block';
        
    })
}
let alarmTouch = -1;
async function memberAlarmSpread() {
    try {
        let result = await memberAlarmList();


        let div = document.getElementById('alarm-spread');
        div.innerHTML = '';

	
        if (result == null) {
            let str = `<ul><li>알람 기능 OFF 상태입니다.</li></ul>`;
         
            div.innerHTML += str;
            return;
        }

        let str = '';
        if (alarmTouch == -1) {
            str = `<ul id="alarmTouch" style="display:none;">`;
            alarmTouch = 1;
        } else {
            str = `<ul id="alarmTouch">`;
        }

        

        for (let i = 0; i < result.length; i++) {
            //  href = "${result[i].alarmContentUrl}"
            str += `<li>`;
            str += `<a href = "${result[i].alarmContentUrl}" data-alarmregat="${result[i].alarmRegAt}" data-membernum="${result[i].memberNum}">${i + 1}. ${result[i].alarmContentName}  :  ${result[i].alarmContentText}</a>`;
            str += `<span> (${changeDate(result[i].alarmRegAt)})</span><br>`;
            str += `</li>`;
        }
        str += `</ul>`;
        div.innerHTML += str;

        

        if (result.length > 0) {
            document.getElementById('alarm-mini-bell').style.display = 'block';
            document.getElementById('alarm-mini-bell').innerText = result.length;
        } else {
            document.getElementById('alarm-mini-bell').style.display = 'none';
        }


    } catch (error) {
        console.log(error);
    }
}

async function memberAlarmList() {
    try {
        const url = "/alarm/alarmList";
        const config = {
            method: 'get'
        };
        const resp = await fetch(url, config);

        if (resp.status === 204) {
            // No Content 상태일 경우, null을 반환하거나 다른 처리를 수행할 수 있음
            return null;
        }
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}


// 2017-08-28 17:22:21 요렇게 들어오는 데이터를 잘 요리해준다
function changeDate(datetime) {
    // 오늘 날짜
    let now = moment(new Date())
    // 오늘과의 시간 차이
    let duration = moment.duration(now.diff(datetime))
    // 변환
    // asSeconds 를 하면 오늘과의 시간차이를 
    // 초단위로 float datatype 으로 보여준다 (3.82 이런식)
    let seconds = duration.asSeconds()
    let minute = duration.asMinutes()
    let hours = duration.asHours()
    let days = duration.asDays()
    let weeks = duration.asWeeks()
    let month = duration.asMonths()
    let year = duration.asYears()

    // 그래서 사용할 때는 parseInt 를 사용해 int 로 바꿔야 한다. 
    if (minute < 1) {
        // 1분 미만이면 초 단위로 보여주고,  
        return parseInt(seconds) + '초 전'
    } else if (hours < 1) {
        // 1시간 미만이면 분 단위로 보여주고
        return parseInt(minute) + '분 전'
    } else if (hours < 24) {
        // 하루 미만이면 시간으로 보여주고
        return parseInt(hours) + '시간 전'
    } else if (weeks < 1) {
        // 일주일 미만이면 일 단위로 보여주고
        return parseInt(days) + '일 전'
    } else if (month < 1) {
        // 한 달 미만이면 주 단위로 보여주고
        return parseInt(weeks) + '주 전'
    } else if (year < 1) {
        // 1년 미만이면 달 단위로 보여주고
        return parseInt(month) + '달 전'
    } else {
        // 1년 이상이면 넌 단위로 보여주고
        return parseInt(year) + '년 전'
    }
}

document.addEventListener('click', (e) => {
    const clickedElement = e.target;
    if (clickedElement.tagName == 'A' && clickedElement.closest('nav')) {
        // data-alarm-id 값을 가져옴
        const regAt = e.target.dataset.alarmregat;
        const num = e.target.dataset.membernum;

        checkData = {
            alarmRegAt: regAt,
            memberNum: num
        }

        memberAlarmCheckCount(checkData).then(result => {
            if (result == 1) {
                console.log('성공');
                memberAlarmSpread();
            } else {
                console.log('실패');
            }

        })
    }

});

async function memberAlarmCheckCount(checkData) {
    try {
        const url = "/alarm/alarmReadCheck";
        const config = {
            method: 'post',
            headers: {
                'Content-Type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify(checkData)
        }
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

function weatherBtn() {
    console.log('테스트');
    let weatherBtn = document.getElementById('weatherBox');

    // 현재 marginLeft 값이 빈 문자열이라면 초기 값으로 설정
    let currentMarginLeft = weatherBtn.style.marginLeft || '-300px';

    if (currentMarginLeft === '-300px') {
        weatherBtn.style.marginLeft = '0px';
    } else {
        weatherBtn.style.marginLeft = '-300px';
    }
    sideLoad();
}
async function sideLoad() {
    let weatherSwitch = -1;
    let forSwitch = -1;
    for (let i = 0; ; i++) {
        if (i == 10) {
            i = 0;
        }
        weatherListSearch().then(weatherInfo => {
            /*
            regionNum; //지역번호
            weatherHighTemp; // 최고온도 (지원안함)
            weatherLowTemp; // 최저온도(지원안함)
            weatherTemp; // 현재기온
            weatherSkyStatus; // 하늘 상태 (1맑음 2구름조금 3구름많음 4흐림)
            weatherRainStatus; //강수형태 (0없음,1비,2눈/비,3눈,4소나기)
            weatherAmount; // 강수량
            weatherPer; //강수량
            weatherDate; // 마지막 갱신 날짜
            weatherTime;	// 마지막 갱신 시간
               0 홍천읍
               1 화촌면
               2 두촌면
               3 내촌면
               4 서석면
               5 영귀미면
               6 남면
               7 서면
               8 북방면
               9 내면
            */
           var week_array = new Array('일', '월', '화', '수', '목', '금', '토');
           var region_grand_child = new Array('홍천읍', '화촌면', '두촌면', '내촌면', '서석면', '영귀미면', '남면', '서면', '북방면', '내면');
           var today_num = new Date().getDay();
         
            let box = document.getElementById("weatherList");
            
            box.innerHTML = '';
            let str = '';

            if (forSwitch == -1) {
                
                for (let i = 0; i < 5; i++){
                    const weatherDate = weatherInfo[i].weatherDate.slice(0, 4) + "년" + weatherInfo[i].weatherDate.slice(4, 6) + "월" + weatherInfo[i].weatherDate.slice(6, 8) + "일";
                    const weatherTime = weatherInfo[i].weatherTime.slice(0, 2) + ":" + weatherInfo[i].weatherTime.slice(2, 4);
                    let Temp = weatherInfo[i].weatherTemp;
                    let weatherStatus = weatherInfo[i].weatherRainStatus;
                    if (weatherStatus == "없음") {
                        weatherStatus = weatherInfo[i].weatherSkyStatus;
                    }
                    let weathericon = "";
                    if (weatherStatus == "맑음") {
                        weathericon = "brightness-high";
                    } else if (weatherStatus == "구름조금") {
                        weathericon = "cloud-sun";
                    } else if (weatherStatus == "구름많음") {
                        weathericon = "cloud";
                    } else if (weatherStatus == "흐림") {
                        weathericon = "cloud-haze";
                    } else if (weatherStatus == "비") {
                        weathericon = "cloud-drizzle";
                    } else if (weatherStatus == "눈/비") {
                        weathericon = "cloud-sleet";
                    } else if (weatherStatus == "소나기") {
                        weathericon = "cloud-rain-heavy";
                    } else {
                        weathericon = "cloud-snow";
                    }
                    if (weatherSwitch == -1) {
                        str += "<p>" + weatherDate + "[" + week_array[today_num] + "]" + weatherTime + "갱신 </p>";
                        weatherSwitch = 1;
                    }
                    str += `<div class="weatherDiv"${i == 4 ? ' style="border-bottom: none;"' : ''}>`;
                    str += "<p>" + region_grand_child[i] + " 날씨</p>";
                    str += '<div><i class="bi bi-' + weathericon + '"></i><span>' + weatherStatus + Temp + '°C' + '</span></div>';
                    str += `</div>`;
                }
                box.innerHTML += str;
                forSwitch = 1;
            } else {
                
                for (let i = 5; i < 10; i++) {
                    const weatherDate = weatherInfo[i].weatherDate.slice(0, 4) + "년" + weatherInfo[i].weatherDate.slice(4, 6) + "월" + weatherInfo[i].weatherDate.slice(6, 8) + "일";
                    const weatherTime = weatherInfo[i].weatherTime.slice(0, 2) + ":" + weatherInfo[i].weatherTime.slice(2, 4);
                    let Temp = weatherInfo[i].weatherTemp;
                    let weatherStatus = weatherInfo[i].weatherRainStatus;
                    if (weatherStatus == "없음") {
                        weatherStatus = weatherInfo[i].weatherSkyStatus;
                    }
                    let weathericon = "";
                    if (weatherStatus == "맑음") {
                        weathericon = "brightness-high";
                    } else if (weatherStatus == "구름조금") {
                        weathericon = "cloud-sun";
                    } else if (weatherStatus == "구름많음") {
                        weathericon = "cloud";
                    } else if (weatherStatus == "흐림") {
                        weathericon = "cloud-haze";
                    } else if (weatherStatus == "비") {
                        weathericon = "cloud-drizzle";
                    } else if (weatherStatus == "눈/비") {
                        weathericon = "cloud-sleet";
                    } else if (weatherStatus == "소나기") {
                        weathericon = "cloud-rain-heavy";
                    } else {
                        weathericon = "cloud-snow";
                    }
                    if (weatherSwitch == 1) {
                        str += "<p>" + weatherDate + "[" + week_array[today_num] + "]" + weatherTime + "갱신 </p>";
                        weatherSwitch = -1;
                    }
                    str += `<div class="weatherDiv"${i == 9 ? ' style="border-bottom: none;"' : ''}>`;
                    str += "<p>" + region_grand_child[i] + " 날씨</p>";
                    str += '<div><i class="bi bi-' + weathericon + '"></i><span>' + weatherStatus + Temp + '°C' + '</span></div>';
                    str += `</div>`;
                }
                box.innerHTML += str;
                forSwitch = -1;
            }



        });

        await timer2(9000);
    }
}