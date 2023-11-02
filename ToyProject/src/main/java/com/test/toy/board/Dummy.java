package com.test.toy.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Random;

import com.test.toy.DBUtil;

public class Dummy {
	
	public static void main(String[] args) {
		
		try {
			
			Connection conn = null;
			PreparedStatement pstat = null;
			
			conn = DBUtil.open();
			
			String sql = "insert into tblBoard (seq, subject, content, regdate, readcount, id) values (seqBoard.nextval, ?, '내용', default, default, 'hong')";
			
			String temp = "새만금과 용맹한 호랑이를 뜻하는 새버미, 제25회 세계스카우트잼버리를 상징한 공식 캐릭터입니다. 인형부터 볼펜, 모자, 티셔츠 등 새버미가 그려진 기념품 종류만 30가지로, 전세계 3만여 대원들에게 판매됐습니다. 디자인 개발비만 3천만 원, 그런데 조직위가 업체에 배정한 수익은 달랑 6백만 원뿐이어서 논란이 커지고 있습니다. [새버미 캐릭터 디자인업체 대표] 사실 상식적으로 이해가 안 가는 거예요. 포스 내역만 달랑 보여주고 이게 끝이다, 이거 그냥 믿어라. (정확히 정산하려면)생산 물량을 먼저 알아야 될 것이고 판매 내역을 봐야 될 것이고.. 근거 자료도 제시하지 않는 일방통행식 정산에 업체는 분을 감추지 못합니다. 당초 조직위는 디자인 업체, 기념품 제작 업체와 각각 계약을 맺고 판매 수익을 나누기로 했습니다. 그런데 조직위가 정산 근거라며 들이민 것은 엑셀 파일 하나. 영수증과 같은 증빙자료 하나 없이 상품명과 판매수량, 판매금액만 적힌 게 전부입니다. 조직위와 제작업체는 그러나 자료 공개가 의무사항이 아니라며 거부하고 있습니다. 계약서에 기념품 판매에 따른 매출 정산을 보고하라고 돼 있을 뿐 근거 자료 제시나 방법은 명시돼 있지 않다는 겁니다. 계는 정부가 꾸린 조직위가 애초 허술한 계약서를 작성한 것이 문제라고 지적합니다.";
			String[] templist = temp.split(" ");
			
			Random rnd = new Random();
			
			String subject = "";
			
			for (int i = 0; i < 5; i++) {
				subject += templist[rnd.nextInt(templist.length)] + " ";
			}
			
			
		} catch (Exception e) {
			System.out.println("Dummy.main()");
			e.printStackTrace();
		}
		
	}

}
