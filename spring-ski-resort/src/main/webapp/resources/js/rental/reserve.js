

document.getElementById("people").addEventListener('click', () => {

    document.getElementById('peopleList').style.display = "block";
})

document.getElementById("nextBtn").addEventListener('click', () => {
    let rentalLiftStart = document.getElementById('rentalLiftStart').value;
    let rentalLiftAdult = document.getElementById('rentalLiftAdult').value;

    if (rentalLiftAdult == "0") {
        alert('인원수를 입력해주세요.');
    } else if (rentalLiftStart == "") {
        alert('날짜를 선택해주세요.');
    } else if (memberEmail == "") {
        alert('로그인 후 예약 가능합니다.');
        location.href = '/member/login';
    } else {
        document.getElementById("innerbox").style.display = "block";
        document.getElementById('nextBtn').style.display = 'none';
    }
})

$(function () {
    let dateRangePicker = document.getElementById('dateRangePicker');

    if (dateRangePicker) {
        let options = {
            singleDatePicker: true,
            showDropdowns: false,
            locale: {
                format: 'YYYY-MM-DD',
                applyLabel: '적용',
                cancelLabel: '취소',
            },
            minDate: moment(),
            startDate: moment(),
            autoUpdateInput: false,
        };

        // 한국어 locale 설정
        moment.locale('ko');

        // DateRangePicker를 호출하여 달력 표시
        $(dateRangePicker).daterangepicker(options, function (start) {
            let selectedDate = start.format('YYYY-MM-DD');
            let selectedDayOfWeek = moment(selectedDate).format('dddd');

            // 선택한 날짜로 "rentalLiftStart" 입력 필드 업데이트
            document.getElementById('rentalLiftStart').value = selectedDate;

            // 동적으로 요일을 표시
            document.getElementById('dateRangePicker').value = `${selectedDate} (${selectedDayOfWeek})`;
        });

        // '적용' 버튼을 눌렀을 때 발생하는 이벤트
        $(dateRangePicker).on('apply.daterangepicker', function (ev, picker) {
            let selectedDate = picker.startDate.format('YYYY-MM-DD');
            let selectedDayOfWeek = moment(selectedDate).format('dddd');

            // 선택한 날짜로 "rentalLiftStart" 입력 필드 업데이트
            document.getElementById('rentalLiftStart').value = selectedDate;

            // 동적으로 요일을 표시
            let displayValue = `${selectedDate} (${selectedDayOfWeek})`;
            console.log(displayValue);  // 디버깅용: 출력된 값 확인
            document.getElementById('dateRangePicker').value = displayValue;

            // 여기에 '적용' 버튼을 클릭했을 때의 추가 동작을 넣으세요.

        });
    }
});
// function updatePeopleCount(inputElement, increment) {
//     let currentCount = parseInt(inputElement.value, 10);
//     let newCount = currentCount + increment;

//     // 최소값은 1로 설정
//     newCount = Math.max(newCount, 1);

//     inputElement.value = newCount;
// }

let selectedDiv = null;
function getDivId(element) {
    if (selectedDiv === element) {
        // 이미 선택된 div를 클릭한 경우, 토글 효과로 테두리 제거
        selectedDiv.style.border = '';
        selectedDiv = null;
    } else {
        // 이전에 선택된 div의 테두리 초기화
        if (selectedDiv !== null) {
            selectedDiv.style.border = '';
        }

        // 현재 클릭한 div의 아이디를 얻어옴
        let divId = element.id;
        console.log(divId);

        // 클릭한 div의 테두리를 빨간색으로 변경
        element.style.border = '2px solid red';

        // 선택된 div 업데이트
        selectedDiv = element;
    }
}


//요금 업데이트
function updateFees(audult, kid, itemName) {
    


    let adultFee = 0;
    let kidFee = 0;

    adultFee = audult * parseInt(rentalLiftAdult.value);
    kidFee = kid * parseInt(rentalLiftKid.value);
    document.getElementById("adultFee").value = adultFee;
    document.getElementById("kidFee").value = kidFee;
    document.getElementById("showadultFee").value = adultFee.toLocaleString() + "원";
    document.getElementById("showkidFee").value = kidFee.toLocaleString() + "원"
    let totalfee = adultFee + kidFee;
    realAmount = totalfee;
    document.getElementById("realpayvalue").value = totalfee;
    document.getElementById("productPrice").value = totalfee;
    document.getElementById('userViewpay').innerText = totalfee.toLocaleString() + "원";
    console.log(itemName);
    document.getElementById('item-name').innerText = itemName;




    // rentalLiftAdultFeeInput.value.toLocaleString();
    // rentalLiftKidFeeInput.value.toLocaleString();
    // 오전권
    // if (morning.checked && parseInt(rentalLiftAdult.value) == 1) {
    //     adultFee = '40000';
    // } else if (morning.checked && parseInt(rentalLiftAdult.value) >= 2) {
    //     adultFee = parseInt(40000 * rentalLiftAdult.value);
    // }
    // if (morning.checked && parseInt(rentalLiftKid.value) == 1) {
    //     kidFee = '30000';
    // } else if (morning.checked && parseInt(rentalLiftKid.value) >= 2) {
    //     kidFee = parseInt(30000 * rentalLiftKid.value);
    // }

    // // 오후권
    // if (afternoon.checked && parseInt(rentalLiftAdult.value) == 1) {
    //     adultFee = '50000';
    // } else if (afternoon.checked && parseInt(rentalLiftAdult.value) >= 2) {
    //     adultFee = parseInt(50000 * rentalLiftAdult.value);
    // }
    // if (afternoon.checked && parseInt(rentalLiftKid.value) == 1) {
    //     kidFee = '40000';
    // } else if (afternoon.checked && parseInt(rentalLiftKid.value) >= 2) {
    //     kidFee = parseInt(40000 * rentalLiftKid.value);
    // }

    // // 주간권
    // if (dayTime.checked && parseInt(rentalLiftAdult.value) == 1) {
    //     adultFee = '60000';
    // } else if (dayTime.checked && parseInt(rentalLiftAdult.value) >= 2) {
    //     adultFee = parseInt(60000 * rentalLiftAdult.value);
    // }
    // if (dayTime.checked && parseInt(rentalLiftKid.value) == 1) {
    //     kidFee = '50000';
    // } else if (dayTime.checked && parseInt(rentalLiftKid.value) >= 2) {
    //     kidFee = parseInt(50000 * rentalLiftKid.value);
    // }

    // // 야간권
    // if (nightTime.checked && parseInt(rentalLiftAdult.value) == 1) {
    //     adultFee = '40000';
    // } else if (nightTime.checked && parseInt(rentalLiftAdult.value) >= 2) {
    //     adultFee = parseInt(40000 * rentalLiftAdult.value);
    // }
    // if (nightTime.checked && parseInt(rentalLiftKid.value) == 1) {
    //     kidFee = '30000';
    // } else if (nightTime.checked && parseInt(rentalLiftKid.value) >= 2) {
    //     kidFee= parseInt(30000 * rentalLiftKid.value);
    // }

    // // 종일권
    // if (allDay.checked && parseInt(rentalLiftAdult.value) == 1) {
    //     adultFee = '75000';
    // } else if (allDay.checked && parseInt(rentalLiftAdult.value) >= 2) {
    //     adultFee = parseInt(75000 * rentalLiftAdult.value);
    // }
    // if (allDay.checked && parseInt(rentalLiftKid.value) == 1) {
    //     kidFee = '65000';
    // } else if (allDay.checked && parseInt(rentalLiftKid.value) >= 2) {
    //     kidFee = parseInt(65000 * rentalLiftKid.value);
    // }

    // // 시즌권
    // if (season.checked && parseInt(rentalLiftAdult.value) == 1) {
    //     adultFee = '380000';
    // } else if (season.checked && parseInt(rentalLiftAdult.value) >= 2) {
    //     adultFee = parseInt(380000 * rentalLiftAdult.value);
    // }
    // if (season.checked && parseInt(rentalLiftKid.value) == 1) {
    //     kidFee = '350000';
    // } else if (season.checked && parseInt(rentalLiftKid.value) >= 2) {
    //     kidFee = parseInt(350000 * rentalLiftKid.value);
    // }


}


//성인 버튼 조작
function addAudltCnt(int) {
    let cnt = parseInt(document.getElementById('audlt-Count').innerText);
    if (cnt < 30) {
        cnt += int;
        if (cnt == 0) {
            cnt = 1;
        }
    }
    document.getElementById('audlt-Count').innerText = cnt;
    AllPeopleCount();
}


//어린이 버튼 조작
document.getElementById("child+Btn").addEventListener('click', () => {
    let cnt = parseInt(document.getElementById('child-Count').innerText);
    if (cnt < 10) {
        cnt += 1;
    }

    document.getElementById('child-Count').innerText = cnt;
    AllPeopleCount();
    //  childAgeSelectCreater();
})

document.getElementById("child-Btn").addEventListener('click', () => {
    let cnt = parseInt(document.getElementById('child-Count').innerText);
    if (cnt > 0) {
        cnt -= 1;
    }
    document.getElementById('child-Count').innerText = cnt;
    AllPeopleCount();
    //  childAgeSelectCreater();
})

/**인원수 세주는거 */
function AllPeopleCount() {
    if (document.getElementById('child-Count').innerText != 0) {
        $('#people').attr('placeholder', `성인 ${document.getElementById('audlt-Count').innerText}명 · 아동 ${document.getElementById('child-Count').innerText}명 `);
    } else {
        $('#people').attr('placeholder', `성인 ${document.getElementById('audlt-Count').innerText}명`);
    }
    document.getElementById('rentalLiftAdult').value = document.getElementById('audlt-Count').innerText;
    document.getElementById('rentalLiftKid').value = document.getElementById('child-Count').innerText;
}

//peoplelist 사라지는 이벤트
document.getElementById('peoplelistClose').addEventListener('click', () => {
    document.getElementById('peopleList').style.display = "none";
})
var targetArea1 = document.getElementById('peopleList');
var targetArea2 = document.getElementById('people');
document.addEventListener('click', function (event) {
    if (!targetArea1.contains(event.target) || !targetArea2.contains(event.target)) {
        document.getElementById('peopleList').style.display = "none";
    }
});
targetArea1.addEventListener('click', function (event) {
    event.stopPropagation();
});
targetArea2.addEventListener('click', function (event) {
    event.stopPropagation();
});


