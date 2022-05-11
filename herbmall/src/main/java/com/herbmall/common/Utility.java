package com.herbmall.common;

import java.sql.Timestamp;
import java.util.Date;

import com.herbmall.reboard.model.ReBoardVO;

public class Utility {
	//파일 업로드 관련 상수
	public static final String UPLOAD_PATH="pds_upload";
	public static final String TEST_PATH="C:\\Users\\EZEN\\git\\acadamy\\herbmall\\src\\main\\webapp\\pds_upload";
	public static String displayRe(int step) {
		String result="";
		if(step>0){
			for(int j=0;j<step;j++){
				result+="&nbsp;";
			}
			result+="<img src='../images/re.gif'>";
		}
		return result;
	}
	
	public static String cutString(String title,int len) {
		String result="";
		if(title.length()>len) {
			result=title.substring(0,len)+"...";
		}else {
			result=title;
		}
		return result;
	}

	public static String displayNew(Date regdate) {
		String result="";
		Date today = new Date();
		// getTime() : 1970.01.01 이후 경과된 시간을 밀리초로 나타내는 메소드
		long diff = (today.getTime()-regdate.getTime())/(1000*60*60);
		if(diff<24) {
			result="<img src='../images/new.gif'>";
		}
		return result;
	}
	
	public static String displayFile(String fileName) {
		String result="";
		
		if(fileName!=null) {
			result="<img src='../images/file.gif'>";
		}
		
		return result;
	}
	/*
	 * public static String getFileInfo(ReBoardVO vo) { String
	 * result=Utility.displayFile(vo.getFileName());
	 * result+=vo.getFileName()+" ("+vo.getFileSize()/1000+"KB) "
	 * +" 다운 :"+vo.getDownCount(); return result; }
	 */
	public static String getFileInfo(String filename, long filesize) {
		String result="";
		if(filename!=null && !filename.isEmpty()) {
			double fsize=filesize/1024.0;
			result+=displayFile(filename)+" ";
			result+=filename;
			result+=" ("+Math.round(fsize*100)/100.0+"KB)";
		}
		return result;
	}
}
