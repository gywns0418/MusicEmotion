package com.example.musicemotion.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.musicemotion.dto.CustomMemberDetails;
import com.example.musicemotion.dto.MemberDTO;

@Service
public class MemberService implements UserDetailsService{
	
    @Autowired
    private JavaMailSender mailSender;
    
    private final MemberDAO memberDAO; // MemberDAO 필드 추가
    private final PasswordEncoder bcryptPasswordEncoder;

    @Autowired
    public MemberService(MemberDAO memberDAO, PasswordEncoder bcryptPasswordEncoder) {
        this.memberDAO = memberDAO; // DAO 주입
        this.bcryptPasswordEncoder = bcryptPasswordEncoder;
    }
    
    
    public void signupPro(MemberDTO member) {
        member.setGrade("ROLE_1");
        member.setPassword(bcryptPasswordEncoder.encode(member.getPassword()));
        memberDAO.signupPro(member);
    }
    
    public String encodePassword(String newPassword) {
    	String encodedPassword = bcryptPasswordEncoder.encode(newPassword);
		return encodedPassword;
    }
    
    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
	    System.out.println("Trying to load user by userId: " + userId);
	    
	    CustomMemberDetails member = null;
	    try {
	        member = memberDAO.findById(userId);
	        System.out.println("Member found: " + member);
	    } catch (Exception e) {
	        System.out.println("Error occurred: " + e.getMessage());
	        e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
	    }

	    if (member == null) {
	        System.out.println("User not found with userId: " + userId);
	        throw new UsernameNotFoundException("User not found with userId: " + userId);
	    }

	    return member;
    }
    
    public boolean isPasswordMatching(String userId, String inputPassword) {
        // DB에서 암호화된 비밀번호를 가져옴
        String encodedPassword = memberDAO.findPasswordByUserId(userId);

        // 입력된 비밀번호와 암호화된 비밀번호 비교
        return bcryptPasswordEncoder.matches(inputPassword, encodedPassword);
    }
    
    public void sendSimpleEmail(String toEmail, String subject, String body) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("your-email@gmail.com");
        message.setTo(toEmail);
        message.setSubject(subject);
        message.setText(body);

        mailSender.send(message);
    }
}
