package com.web.www.domain.member;

import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import com.web.www.security.AuthVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class RegisterMemberDTO {

	private long memberNum;	//회원번호
	
	@Size(min=3, max=12, message="ID는 3~12자 내로 입력해주세요.")
	@NotBlank(message="아이디를 정확히 입력해주세요.")
	private String memberId;	//아이디
	
//	@Pattern(regexp = "(?=.*[a-z])(?=.*[@#$%^&+=])(?=\\S+$).{8,20}" , message = "패스워드는 소문자, 특수문자가 적어도 하나씩은 있어야 하며 최소 8자리여야 하며 최대 20자리까지 가능합니다.")
	@NotBlank(message="비밀번호를 정확히 입력해주세요.")
	private String memberPwd;	//비번
	
	@Size(max=10, message="닉네임은 10자 내로 입력해주세요.")
	@NotBlank(message="닉네임을 정확히 입력해주세요.")
	private String memberAlias;	//닉네임
	
	@NotBlank(message="실명을 입력해주세요.")
	private String memberName;	//실명
	
	@Email
	@NotBlank(message="이메일을 정확히 입력해주세요.")
	private String memberEmail;	//이메일
	
	@NotBlank(message="주소를 입력해주세요.")
	private String memberAddress;	//주소
	
	private String memberAddressDetail;	//상세주소
	
	@NotBlank(message="핸드폰번호를 작성해주세요.")
	private String memberPhoneNum;	//폰번호
	
	@NotBlank(message="나이 약관은 반드시 체크 되어야 합니다.")
	private String memberTerms1; //이용약관
	
	@NotBlank(message="이용 약관은 반드시 체크 되어야 합니다.")
	private String memberTerms2; //이용약관
	private String memberTerms3; //이용약관
	 
	private List<AuthVO> authList;	//여러개의 권한을 리스트로 관리
	
}
