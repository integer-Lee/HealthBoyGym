package com.project.boot.vo;
import java.io.Serializable;
import java.util.Objects;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class MemberVO implements Serializable {
	private static final long serialVersionUID = -1036524153261734687L;
	  
	private String userid;	
	private String name;
	private String pwd;
	private String phone;

	public boolean isEqualPwd(MemberVO member) {
		return pwd.equals(pwd);
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MemberVO other = (MemberVO) obj;
		return Objects.equals(userid, other.userid);
	} 

	@Override
	public int hashCode() {
		return Objects.hash(userid);
	}
}
