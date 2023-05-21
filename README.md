![header](https://capsule-render.vercel.app/api?type=transparent&color=auto&height=300&section=header&text=TodayWithMyDoggy&fontSize=70&animation=fadeIn)

```
쌍용교육센터 세미프로젝트 1조 
최보현(조장), 김영돈, 박재승, 김희수
(2023.03.15 ~ 2023.03.29)
```
<br><br>

# content
1. 프로젝트 개요
2. 팀 소개
3. 개발환경
4. 주요 기능
5. ERD

<br><br>

## 프로젝트 개요🐶 
```
멍멍이와 함께한 하루는 
멍멍이와 함께한 행복한 일상과 정보를 공유하고,
다른 멍멍이들을 만날 수 있는 서비스입니다.
```
<br>
<img alt="image" src="https://user-images.githubusercontent.com/126458406/228165708-482b005c-5dc7-4c54-a1b0-ff3cac407baa.gif">

<br><br>

## 팀 소개🐶 
<table>
    <tr>
      <td align="center"> <a href="https://github.com/lambdaramge"><img src="https://avatars.githubusercontent.com/u/126458406?v=4" width="140px" /><br/>👩 최보현</a><a href="https://solved.ac/chlqhgus3278">
      <br>
        </a></td>
      <td>
        - 우리강아지 게시판<br>
        - Q&A 게시판<br>
        - 쪽지 기능<br>
        - 메인페이지 날씨 정보<br>
        - css: 초기 레이아웃, footer
        </td>
        <td align="center"> <a href="https://github.com/028902"><img src="https://avatars.githubusercontent.com/u/123163275?v=4" width="140px" /><br/>👦🏻 박재승</a><a href="https://solved.ac/conscience98">
      <br>
        </a></td>
      <td>
        - 회원가입, 로그인<br>
        - 카카오로그인 <br> 
        - 아이디, 비밀번호 찾기<br> 
        - 같이걸어요 게시판
        </td>
    </tr>
    <tr>
      <td align="center"> <a href="https://github.com/tenta3802"><img src="https://avatars.githubusercontent.com/u/84509774?v=4" width="140px" /><br/>👦🏻 김영돈</a><a href="https://solved.ac/tenta3802">
      <br>
        </a></td>
      <td>
        - 같이가요 게시판 <br> 
        - 메인 페이지 <br>
        - nav bar, 앨범형 게시판 공통 css 디자인 <br>
        - 전반적인 프론트엔드 디자인 설계 및 구현
      </td>
        <td align="center"> <a href="https://github.com/hesoo98"><img src="https://avatars.githubusercontent.com/u/8851063?v=4" width="140px" /><br/>👦🏻 김희수</a><a href="https://solved.ac/hesoo98">
      <br>
        </a></td>
      <td>
        - 마이페이지<br> 
        - 관리자페이지 <br> 
        - 프로필과 관리자 권한 사용을 위한 공통 기능 개발 <br> 
        - 공지사항 게시판
        </td>
    </tr>
</table>

<br><br>

## 개발환경🐶 
<img alt="image" src="https://user-images.githubusercontent.com/126458406/228120973-1bea8482-a4b3-4766-a599-ff1cb53bb717.png">

<br><br>

## 주요 기능🐶 

### 0️⃣ 공통 기능

- 세션 
  - 관리자 여부를 확인하여 각기 다른 기능 부여 
  - 로그인한 유저에 한해 글쓰기 기능 부여

- Pagination
- Ajax를 통한 좋아요, 댓글 , 조회수 기능
- 글 삭제 시 alert을 통해 삭제 여부를 재확인
- detail page에서 회원의 닉네임을 클릭해 회원이 등록한 강아지의 프로필을 확인하고 쪽지를 보낼 수 있음

<br><br>

### 1️⃣ 회원가입

  |기능|설명|
  |-----|---------------------------|
  |약관| - 약관을 모두 읽어야만 ‘동의’ 버튼이 활성화<br> - 체크박스 미체크시 가입 불가<br> - readonly 속성을 사용하여 약관에 해당하는 textarea를 수정할 수 없게 함|
  |가입조건| - 폼에 입력된 데이터와 db에 저장된 데이터를 비교하여 아이디, 닉네임의 중복 여부를 확인하고, 중복인 경우 회원가입 진행이 불가 <br> - 공백, 띄어쓰기 여부를 확인 <br> - 글자 수와 영문, 숫자, 특수문자 사용 여부를 확인하여 기준을 충족하지 못할 경우 회원가입 진행이 불가 <br> - 비밀번호는 두 번을 입력하고 둘이 일치하지 않으면 회원가입 진행이 불가|

  <details>
  <summary>영상으로 보기</summary>
  <div markdown="1">       
  <img src="https://user-images.githubusercontent.com/126458406/228114727-735ef0d2-1fcc-4fae-93c4-2d2c1a3c4a93.gif" width="800" height="500"/>
  </div>
  </details>

<br><br>

### 2️⃣ 로그인

- 두 가지의 로그인 방식을 구현
  - 일반로그인

  |기능|설명|
  |-----|---------------------------|
  |아이디 저장|세션을 통해 아이디를 세션에 저장할 것인지의 여부를 체크해 아이디 저장 기능 구현|
  |로그인|로그인 직후에는 정보의 등록 여부를 확인하여 해당 정보를 등록하는 페이지 또는 메인페이지로 안내|
  |아이디,비밀번호 찾기| - 가입 시 db에 저장한 전화번호 등의 정보를 통해 아이디와 비밀번호 찾는 기능을 구현 <br> - 비밀번호의 뒷자리는 * 로 표시|

- 카카오로그인

  기존의 Oauth를 통해 발급받은 Access Token으로 정보를 반환받는 형식과 달리 오류 해결을 위해 ajax로 사용자 정보를 직접 db에 저장하는 방식을 채택, 
  카카오 계정에서 받아올 수 있는 정보인 id, nickname, email을 db에 저장


<details>
<summary>영상으로 보기</summary>
<div markdown="1">

> 일반로그인
<img src="https://user-images.githubusercontent.com/126458406/228114937-ee0c8550-26d0-4bd9-bf9c-6487c396e083.gif" width="800" height="500"/>

> 카카오로그인
<img src="https://user-images.githubusercontent.com/126458406/228114881-a916eb03-31c9-4684-83ad-eef38368f92a.gif" width="800" height="500"/>

> 아이디, 비밀번호 찾기
<img src="https://user-images.githubusercontent.com/126458406/228114956-c220eee5-cb98-489e-ad27-6f523c1a03e9.gif" width="800" height="500"/>
</div>
</details>

<br><br>

### 3️⃣ 마이페이지 , 관리자페이지
- 마이페이지

  |기능|설명|
  |--------|-----------|
  |강아지 프로필| - 회원 계정의 인덱스를 참조하여 강아지 프로필을 등록, 수정, 삭제 가능 <br> - 다견가정 고려하여 프로필 다수 등록 가능 <br> - 한 강아지를 대표강아지로 설정하여 다른 게시판 페이지에서 프로필|
  |회원정보 관리|이름, 사진을 포함한 나이, 성별 등 다양한 정보 입력, 수정, 삭제 가능|
  |나의 활동| 내가 쓴 질문 리스트 조회, 바로가기 기능|

- 관리자페이지

  |기능|설명|
  |--------|-----------|
  |회원 차트|**Highchart api** 이용해 사용자 리스트에서 유저 지역 분포를 그래프로 조회|
  |회원 관리| - 일반 사용자에 대한 관리자 권한 부여 <br> - 일반 사용자가 관리자로 전환 시 일반 사용자의 활동이 저장된 테이블을 참조하여 모든 강아지의 프로필이 삭제됨 <br> - 회원 탈퇴 기능 <br> -사용자 이름을 통해 db에 저장된 회원 정보 리스트를 출력하는 검색 기능 구현|
  |질문 리스트|관리자의 답변 등록 여부를 확인하여 답변을 기다리는 질문만 조회|

  <details>
  <summary>상세 사진 보기</summary>
  <div markdown="1">       
    - 마이페이지
  <img src="https://user-images.githubusercontent.com/126458406/228156640-28121ef6-48f2-4766-9417-218bc39be800.gif" width="400" height="300"/>
    - 관리자페이지
  <img src="https://user-images.githubusercontent.com/126458406/228156598-31fb3dc8-19a3-435f-a0e9-18af196e5bdc.gif" width="400" height="300"/>
  </div>
  </details>

<br><br>

### 4️⃣ 메인 날씨 제공⛅️

- Openweathermap에서 제공하는 Current Weather Data api 이용

- Javascript 함수를 통해 사용자의 현재 위도, 경도에 따른 해당 지역명과 기온, 날씨 설명을 표시

- 기온에 따라 산책을 권유하는 메세지 표시

  <details>
  <summary>상세 사진 보기</summary>
  <div markdown="1">       
  <img src="https://user-images.githubusercontent.com/126458406/228120170-e0075168-c2b7-4091-b800-8ff83b9a9074.png" width="400" height="300"/>
  </div>
  </details>

<br><br>

### 5️⃣ 같이걸어요 게시판
  > 지역 별로 산책을 함께할 강아지의 친구를 만들 수 있는 게시판

  |기능|설명|
  |--------|-----------|
  |정렬|체크박스를 통해 원하는 지역의 게시글만 필터링해 표시하도록 구현|
  |일괄 삭제|관리자는 게시글을 체크박스로 선택해 일괄 삭제하는 기능 부여|
  |top|js를 통해 TOP 버튼을 클릭시 페이지를 위쪽으로 이동시키는 기능 구현|

  <details>
  <summary>영상으로 보기</summary>
  <div markdown="1">       
  <img src="https://user-images.githubusercontent.com/126458406/228154857-6ea442d7-ab5f-46b4-bf85-c8bfe5474260.gif" width="400" height="300"/>
  </div>
  </details>

<br><br>

### 6️⃣ 우리강아지 게시판
  > 반려견과의 일상을 공유하고 매주의 인기 강아지를 볼 수 있는 앨범형 게시판
   - 페이지 상단에 인기 강아지를 일주일 간의 좋아요 순으로 정렬해 나타냄
   - 모달 창에서 글을 수정, 삭제

  <details>
  <summary>영상으로 보기</summary>
  <div markdown="1">
  <img src="https://user-images.githubusercontent.com/126458406/228155550-551b97c0-3a80-43b8-82c0-4e1b6b69f5a4.gif" width="400" height="300"/>
  </div>
  </details>

<br><br>

### 7️⃣ 같이가요 게시판
  > 강아지와 함께하기 좋은 장소를 지도를 통해 위치 정보와 함께 공유하는 게시판

  |기능|설명|
  |--------|-----------|
  |미리보기|이미지 등록 후 미리보기 버튼 클릭 시 하단 이미지 출력|
  |카카오 지도 API|- 게시글 등록 시 API를 통해 지도 정보(위도, 경도, 주소)를 입력하여 게시판 DB에 저장 <br> - 주소 입력 시 하단 지도 이미지 출력 <br> - 지도 이미지 위 지도 마커 생성 <br> - 리스트 페이지에서도 게시글마다 지역명을 표시|


  <details>
  <summary>영상으로 보기</summary>
  <div markdown="1">       
  <img src="https://user-images.githubusercontent.com/126458406/228166941-734deeeb-6ba8-4cc9-a485-24eb5489fb13.gif" width="800" height="500"/><br>
  <img src="https://user-images.githubusercontent.com/126458406/228166967-6dd233da-c342-4590-993c-85786905a4de.gif" width="800" height="500"/><br>
  <img src="https://user-images.githubusercontent.com/126458406/228166991-adda66c8-6c22-48b9-8df3-d0ee7b5df8f1.gif" width="800" height="500"/>
  </div>
  </details>

<br><br>

### 8️⃣ Q&A

  |기능|설명|
  |--------|-----------|
  |권한구분| - 관리자인 경우 답변 등록 버튼 생성 <br> - 일반회원인 경우 글쓰기 버튼 생성|
  |비밀글|비밀글, 공개글을 설정 가능하고 자신의 비밀글, 타인의 비밀글, 공개글을 각각 다르게 표시|
  |답변 여부 표시|관리자 답변 여부에 따라 대기중, 답변완료를 표시|

  <details>
  <summary>영상으로 보기</summary>
  <div markdown="1">  

  > 사용자    
  <img src="https://user-images.githubusercontent.com/126458406/228117820-dd877791-ab28-438a-b33b-a44b883ca2d8.gif" width="800" height="500"/>

  > 관리자
  <img src="https://user-images.githubusercontent.com/126458406/228117833-f4980ef6-e0d9-4da5-8b4c-459166c12569.gif" width="800" height="500"/>
  </div>
  </details>

<br><br>

### 9️⃣ 공지사항
  > 관리자는 공지사항을 게시하고 유저는 읽기 전용으로 사용하는 게시판

  - 세션을 통해 관리자와 일반 사용자를 구분 
  - 관리자는 글 등록, 수정, 삭제가 가능
  - 일반 사용자는 열람만 가능

  <details>
  <summary>영상으로 보기</summary>
  <div markdown="1">       
  <img src="https://user-images.githubusercontent.com/126458406/228116741-60f0a791-2af0-4eef-b85a-7bf8722db589.gif" width="800" height="500"/>
  </div>
  </details>

<br><br>

### 🔟 쪽지함📫

  |기능|설명|
  |--------|-----------|
  |알림|읽지 않은 메시지의 개수를 nav bar의 알림으로 표시|
  |쪽지 발송|게시판의 게시글을 통해 쪽지 발송 가능|
  |상세페이지| - Ajax를 통해 구현 <br> - 쪽지의 상세페이지를 클릭하자마자 회색으로 표시하여 읽음 여부를 영구적으로 확인 가능 <br> - 답장 가능 <br> - checkbox를 통해 쪽지 일괄 삭제|

  <details>
  <summary>영상으로 보기</summary>
  <div markdown="1">       
  <img src="https://user-images.githubusercontent.com/126458406/228117845-d856c92b-f34c-4aee-ae2d-1fc4ea00c7b7.gif" width="800" height="500"/>
  </div>
  </details>

<br><br>

### ERD🐶 
<img src="https://user-images.githubusercontent.com/126458406/228153633-22633d48-43c1-4228-a1ee-b3064bd8d2bb.png" width="600" height="400"/>
<br><br>

### etc🐶 
- AWS 주소
  - http://semiprojecttodaywithmydoggy-env.eba-nqwagudp.ap-northeast-2.elasticbeanstalk.com/
