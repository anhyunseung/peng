package poly.dto;

public class CommonDTO {

	private String notice_seq;
	private String notice_title;
	private String notice_com_count;
	private String bbm_seq;
	private String bbm_title;
	private String bbm_com_count;

	public String getnotice_seq() {
		return notice_seq;
	}

	public void setnotice_seq(String notice_seq) {
		this.notice_seq = notice_seq;
	}

	public String getnotice_Title() {
		return notice_title;
	}

	public void setnotice_Title(String notice_title) {
		this.notice_title = notice_title;
	}
	
	public String getbbm_seq() {
		return bbm_seq;
	}

	public void setbbm_seq(String bbm_seq) {
		this.bbm_seq = bbm_seq;
	}

	public String getbbm_Title() {
		return bbm_title;
	}

	public void setbbm_Title(String bbm_title) {
		this.bbm_title = bbm_title;
	}
	
	public String getnotice_com_count() {
		return notice_com_count;
	}

	public void setnotice_com_count(String notice_com_count) {
		this.notice_com_count = notice_com_count;
	}
	
	public String getbbm_com_count() {
		return bbm_com_count;
	}

	public void setbbm_com_count(String bbm_com_count) {
		this.bbm_com_count = bbm_com_count;
	}
	
}