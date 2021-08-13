package Board.dto;

import java.util.Date;

public class Board {
  
	private int bNo;
	private String bPw;
	private String bNick;
	private Date bCreateDate;
	private String bContent;
	private String bTitle;
	private int rnum;
	private String bDeleteState;
	private int bOriginNo;
	private int bGroupOrd;
	private int bGroupLayer;
	private int bReplyCount;
	@Override
	public String toString() {
		return "Board [bNo=" + bNo + ", bPw=" + bPw + ", bNick=" + bNick + ", bCreateDate=" + bCreateDate
				+ ", bContent=" + bContent + ", bTitle=" + bTitle + ", rnum=" + rnum + ", bDeleteState=" + bDeleteState
				+ ", bOriginNo=" + bOriginNo + ", bGroupOrd=" + bGroupOrd + ", bGroupLayer=" + bGroupLayer
				+ ", bReplyCount=" + bReplyCount + "]";
	}
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public String getbPw() {
		return bPw;
	}
	public void setbPw(String bPw) {
		this.bPw = bPw;
	}
	public String getbNick() {
		return bNick;
	}
	public void setbNick(String bNick) {
		this.bNick = bNick;
	}
	public Date getbCreateDate() {
		return bCreateDate;
	}
	public void setbCreateDate(Date bCreateDate) {
		this.bCreateDate = bCreateDate;
	}
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getbDeleteState() {
		return bDeleteState;
	}
	public void setbDeleteState(String bDeleteState) {
		this.bDeleteState = bDeleteState;
	}
	public int getbOriginNo() {
		return bOriginNo;
	}
	public void setbOriginNo(int bOriginNo) {
		this.bOriginNo = bOriginNo;
	}
	public int getbGroupOrd() {
		return bGroupOrd;
	}
	public void setbGroupOrd(int bGroupOrd) {
		this.bGroupOrd = bGroupOrd;
	}
	public int getbGroupLayer() {
		return bGroupLayer;
	}
	public void setbGroupLayer(int bGroupLayer) {
		this.bGroupLayer = bGroupLayer;
	}
	public int getbReplyCount() {
		return bReplyCount;
	}
	public void setbReplyCount(int bReplyCount) {
		this.bReplyCount = bReplyCount;
	}
	
	
	
	
}
