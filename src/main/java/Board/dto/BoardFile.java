package Board.dto;

import java.util.Date;

public class BoardFile {

	private int bfFileno;
	private int bNo;
	private String bfOriginName;
	private String bfStoredName;
	private Date bfCreateDate;
	private int bfSize;
	private String bfContentType;
	@Override
	public String toString() {
		return "BoardFile [bfFileno=" + bfFileno + ", bNo=" + bNo + ", bfOriginName=" + bfOriginName + ", bfStoredName="
				+ bfStoredName + ", bfCreateDate=" + bfCreateDate + ", bfSize=" + bfSize + ", bfContentType="
				+ bfContentType + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
	public int getBfFileno() {
		return bfFileno;
	}
	public void setBfFileno(int bfFileno) {
		this.bfFileno = bfFileno;
	}
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public String getBfOriginName() {
		return bfOriginName;
	}
	public void setBfOriginName(String bfOriginName) {
		this.bfOriginName = bfOriginName;
	}
	public String getBfStoredName() {
		return bfStoredName;
	}
	public void setBfStoredName(String bfStoredName) {
		this.bfStoredName = bfStoredName;
	}
	public Date getBfCreateDate() {
		return bfCreateDate;
	}
	public void setBfCreateDate(Date bfCreateDate) {
		this.bfCreateDate = bfCreateDate;
	}
	public int getBfSize() {
		return bfSize;
	}
	public void setBfSize(int bfSize) {
		this.bfSize = bfSize;
	}
	public String getBfContentType() {
		return bfContentType;
	}
	public void setBfContentType(String bfContentType) {
		this.bfContentType = bfContentType;
	}
	
	
	
	
}
