package Board.dto;

import java.util.Date;

public class Comments {
	private int cNo;
	private int bNo;
	private String cPw;
	private String cNick;
	private String cContent;
	private Date cCreateDate;
	@Override
	public String toString() {
		return "Comments [cNo=" + cNo + ", bNo=" + bNo + ", cPw=" + cPw + ", cNick=" + cNick + ", cContent=" + cContent
				+ ", cCreateDate=" + cCreateDate + "]";
	}
	public int getcNo() {
		return cNo;
	}
	public void setcNo(int cNo) {
		this.cNo = cNo;
	}
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public String getcPw() {
		return cPw;
	}
	public void setcPw(String cPw) {
		this.cPw = cPw;
	}
	public String getcNick() {
		return cNick;
	}
	public void setcNick(String cNick) {
		this.cNick = cNick;
	}
	public String getcContent() {
		return cContent;
	}
	public void setcContent(String cContent) {
		this.cContent = cContent;
	}
	public Date getcCreateDate() {
		return cCreateDate;
	}
	public void setcCreateDate(Date cCreateDate) {
		this.cCreateDate = cCreateDate;
	}
	
	
}
