let itemTitle = '스키';
let itemGrade = '하급';
let lowItem = document.getElementById('lowItem');
let midItem = document.getElementById('midItem');
let premiumItem = document.getElementById('premiumItem');

let skiItem = document.getElementById('skiItem');
let boardItem = document.getElementById('boardItem');
let wearItem = document.getElementById('wearItem');

skiItem.addEventListener('click', () => {
     console.log('스키 선택');
     itemTitle = '스키';
     document.getElementById('skiItemList').style.display = 'block';
     document.getElementById('boardItemList').style.display = 'none';
     document.getElementById('wearItemList').style.display = 'none';
     document.getElementById('skiLowItemImageBox').style.display = 'flex';
     document.getElementById('skiMidItemImageBox').style.display = 'none';
     document.getElementById('skiPremiumItemImageBox').style.display = 'none';
     document.getElementById('boardLowItemImageBox').style.display = 'none';
     document.getElementById('boardMidItemImageBox').style.display = 'none';
     document.getElementById('boardPremiumItemImageBox').style.display = 'none';
     document.getElementById('wearLowItemImageBox').style.display = 'none';
     document.getElementById('wearMidItemImageBox').style.display = 'none';
     document.getElementById('wearPremiumItemImageBox').style.display = 'none';

})
boardItem.addEventListener('click', () => {
     console.log('보드 선택');
     itemTitle = '보드';
     document.getElementById('skiItemList').style.display = 'none';
     document.getElementById('boardItemList').style.display = 'block';
     document.getElementById('wearItemList').style.display = 'none';
     document.getElementById('skiLowItemImageBox').style.display = 'none';
     document.getElementById('skiMidItemImageBox').style.display = 'none';
     document.getElementById('skiPremiumItemImageBox').style.display = 'none';
     document.getElementById('boardLowItemImageBox').style.display = 'flex';
     document.getElementById('boardMidItemImageBox').style.display = 'none';
     document.getElementById('boardPremiumItemImageBox').style.display = 'none';
     document.getElementById('wearLowItemImageBox').style.display = 'none';
     document.getElementById('wearMidItemImageBox').style.display = 'none';
     document.getElementById('wearPremiumItemImageBox').style.display = 'none';
})
wearItem.addEventListener('click', () => {
     console.log('의류 선택');
     itemTitle = '의류';
     document.getElementById('skiItemList').style.display = 'none';
     document.getElementById('boardItemList').style.display = 'none';
     document.getElementById('wearItemList').style.display = 'block';
     document.getElementById('skiLowItemImageBox').style.display = 'none';
     document.getElementById('skiMidItemImageBox').style.display = 'none';
     document.getElementById('skiPremiumItemImageBox').style.display = 'none';
     document.getElementById('boardLowItemImageBox').style.display = 'none';
     document.getElementById('boardMidItemImageBox').style.display = 'none';
     document.getElementById('boardPremiumItemImageBox').style.display = 'none';
     document.getElementById('wearLowItemImageBox').style.display = 'flex';
     document.getElementById('wearMidItemImageBox').style.display = 'none';
     document.getElementById('wearPremiumItemImageBox').style.display = 'none';
})


lowItem.addEventListener('click', () => {
     itemGrade = '하급';
     if (itemTitle == '스키') {
          document.getElementById('skiLowItemImageBox').style.display = 'flex';
          document.getElementById('skiMidItemImageBox').style.display = 'none';
          document.getElementById('skiPremiumItemImageBox').style.display = 'none';
          document.getElementById('boardLowItemImageBox').style.display = 'none';
          document.getElementById('boardMidItemImageBox').style.display = 'none';
          document.getElementById('boardPremiumItemImageBox').style.display = 'none';
          document.getElementById('wearLowItemImageBox').style.display = 'none';
          document.getElementById('wearMidItemImageBox').style.display = 'none';
          document.getElementById('wearPremiumItemImageBox').style.display = 'none';
     } else if (itemTitle == '보드') {
          document.getElementById('skiLowItemImageBox').style.display = 'none';
          document.getElementById('skiMidItemImageBox').style.display = 'none';
          document.getElementById('skiPremiumItemImageBox').style.display = 'none';
          document.getElementById('boardLowItemImageBox').style.display = 'flex';
          document.getElementById('boardMidItemImageBox').style.display = 'none';
          document.getElementById('boardPremiumItemImageBox').style.display = 'none';
          document.getElementById('wearLowItemImageBox').style.display = 'none';
          document.getElementById('wearMidItemImageBox').style.display = 'none';
          document.getElementById('wearPremiumItemImageBox').style.display = 'none';
     } else if (itemTitle == '의류') {
          document.getElementById('skiLowItemImageBox').style.display = 'none';
          document.getElementById('skiMidItemImageBox').style.display = 'none';
          document.getElementById('skiPremiumItemImageBox').style.display = 'none';
          document.getElementById('boardLowItemImageBox').style.display = 'none';
          document.getElementById('boardMidItemImageBox').style.display = 'none';
          document.getElementById('boardPremiumItemImageBox').style.display = 'none';
          document.getElementById('wearLowItemImageBox').style.display = 'flex';
          document.getElementById('wearMidItemImageBox').style.display = 'none';
          document.getElementById('wearPremiumItemImageBox').style.display = 'none';
     }
})
midItem.addEventListener('click', () => {
     itemGrade = '중급';
     if (itemTitle == '스키') {
          document.getElementById('skiLowItemImageBox').style.display = 'none';
          document.getElementById('skiMidItemImageBox').style.display = 'flex';
          document.getElementById('skiPremiumItemImageBox').style.display = 'none';
          document.getElementById('boardLowItemImageBox').style.display = 'none';
          document.getElementById('boardMidItemImageBox').style.display = 'none';
          document.getElementById('boardPremiumItemImageBox').style.display = 'none';
          document.getElementById('wearLowItemImageBox').style.display = 'none';
          document.getElementById('wearMidItemImageBox').style.display = 'none';
          document.getElementById('wearPremiumItemImageBox').style.display = 'none';
     } else if (itemTitle == '보드') {
          document.getElementById('skiLowItemImageBox').style.display = 'none';
          document.getElementById('skiMidItemImageBox').style.display = 'none';
          document.getElementById('skiPremiumItemImageBox').style.display = 'none';
          document.getElementById('boardLowItemImageBox').style.display = 'none';
          document.getElementById('boardMidItemImageBox').style.display = 'flex';
          document.getElementById('boardPremiumItemImageBox').style.display = 'none';
          document.getElementById('wearLowItemImageBox').style.display = 'none';
          document.getElementById('wearMidItemImageBox').style.display = 'none';
          document.getElementById('wearPremiumItemImageBox').style.display = 'none';
     } else if (itemTitle == '의류') {
          document.getElementById('skiLowItemImageBox').style.display = 'none';
          document.getElementById('skiMidItemImageBox').style.display = 'none';
          document.getElementById('skiPremiumItemImageBox').style.display = 'none';
          document.getElementById('boardLowItemImageBox').style.display = 'none';
          document.getElementById('boardMidItemImageBox').style.display = 'none';
          document.getElementById('boardPremiumItemImageBox').style.display = 'none';
          document.getElementById('wearLowItemImageBox').style.display = 'none';
          document.getElementById('wearMidItemImageBox').style.display = 'flex';
          document.getElementById('wearPremiumItemImageBox').style.display = 'none';
     }
})
premiumItem.addEventListener('click', () => {
     itemGrade = '고급';
     if (itemTitle == '스키') {
          document.getElementById('skiLowItemImageBox').style.display = 'none';
          document.getElementById('skiMidItemImageBox').style.display = 'none';
          document.getElementById('skiPremiumItemImageBox').style.display = 'flex';
          document.getElementById('boardLowItemImageBox').style.display = 'none';
          document.getElementById('boardMidItemImageBox').style.display = 'none';
          document.getElementById('boardPremiumItemImageBox').style.display = 'none';
          document.getElementById('wearLowItemImageBox').style.display = 'none';
          document.getElementById('wearMidItemImageBox').style.display = 'none';
          document.getElementById('wearPremiumItemImageBox').style.display = 'none';
     } else if (itemTitle == '보드') {
          document.getElementById('skiLowItemImageBox').style.display = 'none';
          document.getElementById('skiMidItemImageBox').style.display = 'none';
          document.getElementById('skiPremiumItemImageBox').style.display = 'none';
          document.getElementById('boardLowItemImageBox').style.display = 'none';
          document.getElementById('boardMidItemImageBox').style.display = 'none';
          document.getElementById('boardPremiumItemImageBox').style.display = 'flex';
          document.getElementById('wearLowItemImageBox').style.display = 'none';
          document.getElementById('wearMidItemImageBox').style.display = 'none';
          document.getElementById('wearPremiumItemImageBox').style.display = 'none';
     } else if (itemTitle == '의류') {
          document.getElementById('skiLowItemImageBox').style.display = 'none';
          document.getElementById('skiMidItemImageBox').style.display = 'none';
          document.getElementById('skiPremiumItemImageBox').style.display = 'none';
          document.getElementById('boardLowItemImageBox').style.display = 'none';
          document.getElementById('boardMidItemImageBox').style.display = 'none';
          document.getElementById('boardPremiumItemImageBox').style.display = 'none';
          document.getElementById('wearLowItemImageBox').style.display = 'none';
          document.getElementById('wearMidItemImageBox').style.display = 'none';
          document.getElementById('wearPremiumItemImageBox').style.display = 'flex';
     }
})



// 렌탈장비명, 요금 표시

function updateItemInfo(itemName, adultFee, kidFee) {
     let rentalItemName = "";
     let rentalAdultFee = 0;
     let rentalKidFee = 0;

     rentalAdultFee = adultFee * parseInt(rentalReserveAdult.value);
     rentalKidFee = kidFee * parseInt(rentalReserveKid.value);
     document.getElementById('showItemName').value = rentalItemName;
     document.getElementById('showAdultFee').value = rentalAdultFee.toLocaleString() + "원";
     document.getElementById('showKidFee').value = rentalKidFee.toLocaleString() + "원";

     let rentalTotalFee = rentalAdultFee + rentalKidFee;
     document.getElementById('showTotalFee').value = rentalTotalFee.toLocaleString() + "원";

}


// 슬라이드 함수
function initSlide(containerId) {
     let container = document.getElementById(containerId);
     let slides = container.querySelectorAll('.slide');
     let value = 0;

     let slideWidth = 400;

     
     // 이미지 클론
     // function cloneSlides() {
     //      let firstSlideClone = slides[0].cloneNode(true);
     //      let lastSlideClone = slides[slides.length - 1].cloneNode(true);
     //      container.appendChild(firstSlideClone);
     //      container.appendChild(lastSlideClone);
     // }

     // 다음 이미지로 이동
     function next() {
          value -= slideWidth;
          if (value < -((slides.length - 4) * slideWidth)) {
               value = -((slides.length - 4) * slideWidth);
          }
          transitionSlides();
     }

     // 이전 이미지로 이동
     function prev() {
          value += slideWidth;
          if (value > 0) {
               value = 0;
          }
          transitionSlides();
     }

     // 이미지 전환 효과
     function transitionSlides() {
          slides.forEach(slide => {
               slide.style.transition = 'transform 0.5s ease';
               slide.style.transform = 'translateX(' + value + 'px)';
          });

          // 슬라이드가 끝에 도달하면 초기 위치로 이동
          // if (value <= -((slides.length - 2) * slideWidth)) {
          //      resetSlides();
          // }

          // // 슬라이드가 처음으로 돌아갈 경우
          // if (value >= 0) {
          //      resetSlides();
          // }
     }

     // 슬라이드 초기 위치로 이동
     // function resetSlides() {
     //      setTimeout(() => {
     //           slides.forEach(slide => {
     //                slide.style.transition = '0s';
     //                value = 0;
     //                slide.style.transform = 'translateX(' + value + 'px)';
     //           });
     //      }, 300);
     // }

     // cloneSlides();

     if (document.getElementById('slideNextBtn')) {
          document.getElementById('slideNextBtn').addEventListener('click', next);
     }
     if (document.getElementById('slidePrevBtn')) {
          document.getElementById('slidePrevBtn').addEventListener('click', prev);
     }
}

// 각 아이템에 대해 슬라이드 초기화 함수 호출
initSlide('skiLowItemImageBox');
initSlide('skiMidItemImageBox');
initSlide('skiPremiumItemImageBox');
initSlide('boardLowItemImageBox');
initSlide('boardMidItemImageBox');
initSlide('boardPremiumItemImageBox');
initSlide('wearLowItemImageBox');
initSlide('wearMidItemImageBox');
initSlide('wearPremiumItemImageBox');


/*   장바구니 기능    */

function fnContains(str, substr) {
     return str.indexOf(substr) !== -1;
}


///


// 스키 아이템
document.addEventListener('DOMContentLoaded', function () {

     document.getElementById('skiItemList').addEventListener('click', (e) => {
          if (e.target.tagName === 'IMG') {
               let itemNum = e.target.getAttribute('data-num');
               let itemName = e.target.getAttribute('data-name');
               let itemAdultFee = e.target.getAttribute('data-adultFee');
               let itemKidFee = e.target.getAttribute('data-kidFee');
               let itemImageUrl = e.target.getAttribute('data-img');

               if (fnContains(itemName, '주니어')) {
                    console.log(itemNum, itemName, itemKidFee);
                    shoppingBasket(itemNum, itemName, itemKidFee, itemImageUrl);
               } else {
                    console.log(itemName, itemAdultFee);
                    shoppingBasket(itemNum, itemName, itemAdultFee, itemImageUrl);
               }

          }
     });

})

// 보드 아이템
document.addEventListener('DOMContentLoaded', function () {

     document.getElementById('boardItemList').addEventListener('click', (e) => {
          if (e.target.tagName === 'IMG') {
               let itemNum = e.target.getAttribute('data-num');
               let itemName = e.target.getAttribute('data-name');
               let itemAdultFee = e.target.getAttribute('data-adultFee');
               let itemKidFee = e.target.getAttribute('data-kidFee');
               let itemImageUrl = e.target.getAttribute('data-img');

               if (fnContains(itemName, '주니어')) {
                    console.log(itemNum, itemName, itemKidFee);
                    shoppingBasket(itemNum, itemName, itemKidFee, itemImageUrl);
               } else {
                    console.log(itemNum, itemName, itemAdultFee);
                    shoppingBasket(itemNum, itemName, itemAdultFee, itemImageUrl);
               }

          }
     });

})


// 의류/보호장비 아이템
document.addEventListener('DOMContentLoaded', function () {
     document.getElementById('wearItemList').addEventListener('click', (e) => {
          if (e.target.tagName === 'IMG') {
               let itemNum = e.target.getAttribute('data-num');
               let itemName = e.target.getAttribute('data-name');
               let itemAdultFee = e.target.getAttribute('data-adultFee');
               let itemImageUrl = e.target.getAttribute('data-img');

               shoppingBasket(itemNum, itemName, itemAdultFee, itemImageUrl);
          }
     });

})

/*********** 장바구니 로직 *************/
/*********** 장바구니 로직 *************/
/*********** 장바구니 로직 *************/
//장바구니 css 스위치입니다. 누르고 나오게 하기
let shoppingBasketSwitch = -1;

let itemsArray = [];
let itemSum = 0;
let localStorageCnt = 0;
let localStorageSwitch = -1;
document.getElementById('shoppingbag').addEventListener('click',()=>{ 
     let shoppingBasket = document.getElementById('shoppingBasket');
     if(shoppingBasket.style.right == '-350px'){
          shoppingBasket.style.right = 0;
     }else{
          shoppingBasket.style.right = '-350px';
     }
})
function shoppingBasket(itemNum, itemName, price, itemImageUrl) {


     if (memberEmail.length <= 0) {
          alert('상품구매는 회원만 가능합니다.');
          location.href = '/member/login';
          return;
     }

  


   
     
     if (itemsArray.length >= 5) {
          alert("최대 5개만 예약 가능합니다");
          
          return;
     }
     document.getElementById('shoppingbagNum').innerHTML = `<span>${itemsArray.length+1}</span>`;

     let itemsConfig = {
          rentalItemNum: itemNum,
          rentalItemName: itemName,
          rentalItemPrice: price,
          rentalItemUrl: itemImageUrl,
     };

     itemsArray.push(itemsConfig);
     itemSum += parseInt(price);

     console.log(itemsArray);

     renderBasket();
}


function renderBasket() {
     let itemSelectDiv = document.getElementById('itemSelectDiv');
     itemSelectDiv.innerHTML = '';
     // localStorage.clear();   
     itemsArray.forEach(function (item, index) {
          let basketTemp = `<div class="basketContainer" data-index="${index}">
                    <div>
                         <img src="${item.rentalItemUrl}" width="100px" height="100px">
                         <i class="bi bi-x basketClose" data-index="${index}"></i>
                    </div>
                    <div>
                         <p>${item.rentalItemName}</p>
                         <p>${parseInt(item.rentalItemPrice).toLocaleString('ko-KR')}원</p>
                    </div>
               </div>`;
          itemSelectDiv.innerHTML += basketTemp;
          // localStorage.setItem(`${index}`, item);
     });

     let basketTemp = `
          <div class="itemPriceSum">
               <p> 합계 : ${itemSum.toLocaleString('ko-KR')}원</p>
          </div>
     `;
     itemSelectDiv.innerHTML += basketTemp;
}

function removeItem(index) {
     let removedItem = itemsArray.splice(index, 1)[0];
     itemSum -= parseInt(removedItem.rentalItemPrice);
     // localStorage.removeItem(`${index}`);
     renderBasket();

     let shoppingBasket = document.getElementById('shoppingBasket');
     let itemContainer = document.getElementById('itemContainer');
     document.getElementById('shoppingbagNum').innerText =itemsArray.length;
     

     if (itemsArray.length == 0) {
          shoppingBasket.style.right = '-350px';
          shoppingBasketSwitch = -1;
     }
}

document.getElementById('itemSelectDiv').addEventListener('click', function (event) {
     if (event.target.classList.contains('basketClose')) {
          removeItem(event.target.getAttribute('data-index'));
          console.log(itemsArray);
     }
});

/***************************************/
/***예 약 하 기 ***/
// if (document.getElementById('reserveBtn')) {
//      document.getElementById('reserveBtn').addEventListener('click', () => {

//           localStorage.clear();

//           for (let i = 0; i < itemsArray.length; i++) {
//                localStorage.setItem(`${i}`, JSON.stringify(itemsArray));
//           }

//           location.href = '/rental/item-reserve';
//      })
// }



function reservationBtn() {
     window.location.href = '/rental/item-reserve?data=' + encodeURIComponent(JSON.stringify(itemsArray));
}

// async function itemsBasketToServer() {
//      try {
//           const url = '/rental/itemsBasket';
//           const config = {
//                method: 'post',
//                headers: {
//                     'Content-Type': 'application/json; charset=utf-8'
//                },
//                body: JSON.stringify(itemsArray)
//           };
//           let resp = await fetch(url, config);
//           if (resp.ok) {
//                let result = await resp.json();
//                console.log("배열값 :: ", result);
//                window.location.href = '/rental/item-reserve?data=' + encodeURIComponent(JSON.stringify(result));
//           } else {
//                console.error('비동기 통신 실패', resp.status);
//           }

//      } catch (error) {
//           console.log(error);
//      }
// }



// let imageBox = document.querySelectorAll('.itemImageBox .slide img');
// let shopContainer = document.querySelector('.shopContainer');

// //로그인된 유저가 리프트권이 있다면? true / false

// if (true) {
//      imageBox.forEach(function (image) {
//           image.addEventListener('click', function () {
//                shopContainer.style.display = 'block';
//           })
//      })
// }
