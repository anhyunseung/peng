package poly.dto;

import java.util.List;

public class NoticeDTO {

	private String notice_seq;
	private String title;
	private String contents;
	private String user_id;
	private String read_cnt;
	private String reg_user_no;
	private String reg_dt;
	private String chg_user_no;
	private String chg_dt;
	private List<Comment_noticeDTO> clist;
	private String com_count;
	private String search;

	public String getnotice_seq() {
		return notice_seq;
	}

	public void setnotice_seq(String notice_seq) {
		this.notice_seq = notice_seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getRead_cnt() {
		return read_cnt;
	}

	public void setRead_cnt(String read_cnt) {
		this.read_cnt = read_cnt;
	}

	public String getReg_user_no() {
		return reg_user_no;
	}

	public void setReg_user_no(String reg_user_no) {
		this.reg_user_no = reg_user_no;
	}

	public String getReg_dt() {
		return reg_dt;
	}

	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}

	public String getChg_user_np() {
		return chg_user_no;
	}

	public void setChg_user_no(String chg_user_no) {
		this.chg_user_no = chg_user_no;
	}

	public String getChg_dt() {
		return chg_dt;
	}

	public void setChg_dt(String chg_dt) {
		this.chg_dt = chg_dt;
	}

	public List<Comment_noticeDTO> getClist() {
		return clist;
	}

	public void setClist(List<Comment_noticeDTO> clist) {
		this.clist = clist;
	}
	
	public String getCom_count() {
		return com_count;
	}

	public void setCom_count(String com_count) {
		this.com_count = com_count;
	}
	
	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}
	
}