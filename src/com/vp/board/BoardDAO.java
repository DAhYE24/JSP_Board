package com.vp.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
	private BoardDBConnect dbconnect = null;
	private String sql = "";

	public BoardDAO() {
		dbconnect = new BoardDBConnect();
	}

	/* ������ ���ڵ� */
	public String encodeData(String data) {
		try {
			data = new String(data.getBytes("8859_1"), "euc-kr");
		} catch (Exception e) {
		}
		return data;
	}

	/* TODO : ī���� ��� ����*/
	/* �Խù� ���� ī���� */
	public int countPost() {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null; // �����ϵ� sql���� DBMS�� ����
		ResultSet rs = null;
		int cnt = 0;
		try {
			sql = "select count(*) from BOARD_TB";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt, rs);
		}
		return cnt;
	}

	/* �Խ��� ��� ���� */
	public ArrayList<BoardVO> getList(String keyField, String keyWord) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardVO> arrList = new ArrayList<BoardVO>();
		try {
			sql = "select BOARDIDX,USERNAME,TITLE,HIT,CREATEAT from BOARD_TB ";			
			if(keyWord != null && !keyWord.equals("") ){ // �˻��� ���� �Խñ� �޾ƿ���
				String str = new String(keyWord.trim().getBytes("iso-8859-1"), "euc-kr");
                sql +="where "+keyField.trim()+" like '%"+ str +"%' ";
            }
			sql += "order by BOARDIDX desc"; // �Խ��� ��ȣ�� ����
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) { // �Խñ��� ���� ������ while�� �ݺ�
				BoardVO vo = new BoardVO();
				vo.setBoardIdx(rs.getInt(1));
				vo.setUserName(rs.getString(2));
				vo.setTitle(rs.getString(3));
				vo.setHit(rs.getInt(4));
				vo.setCreateAt(rs.getString(5));
				arrList.add(vo);
			}
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt, rs);
		}
		return arrList;
	}

	/* �Խñ� ��ȸ�� ���� */
	public void updateHit(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			sql = "update BOARD_TB set HIT=HIT+1 where BOARDIDX=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt);
		}
	}

	/* ������ �� �ҷ����� */
	public BoardVO loadSelectedPost(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardVO vo = null;

		try {
			sql = "select USERNAME,TITLE,MEMO,HIT,CREATEAT from BOARD_TB where BOARDIDX=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if (rs.next()) { // ������ �Խù��� DB�� �ִٸ� ���� �޾ƿ���
				vo = new BoardVO();
				vo.setUserName(rs.getString(1));
				vo.setTitle(rs.getString(2));
				vo.setMemo(rs.getString(3));
				vo.setHit(rs.getInt(4));
				vo.setCreateAt(rs.getString(5));
			}
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt, rs);
		}
		return vo;
	}

	/* �Խñ� �ۼ��ϱ� */
	public void writePost(BoardVO vo) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			// �������� �����Ͽ� �ڵ����� BOARDIDX(�۹�ȣ, PK) �÷��� ���������� ���� 
			sql = "insert into BOARD_TB(BOARDIDX,USERNAME,PASSWORD,TITLE,MEMO) values(BOARDIDX_SEQ.NEXTVAL,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, encodeData(vo.getUserName()));
			pstmt.setString(2, encodeData(vo.getPassword()));
			pstmt.setString(3, encodeData(vo.getTitle()));
			pstmt.setString(4, encodeData(vo.getMemo()));
			pstmt.execute();
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt);
		}
	}

	/* �Խñ� �����ϱ� */
	public void modifyPost(BoardVO vo, int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			// ���� �����Ǹ� ���� �ð����� ����
			sql = "update BOARD_TB set TITLE=?,USERNAME=?,PASSWORD=?,MEMO=?,UPDATEAT=sysdate where BOARDIDX=?";
			pstmt = con.prepareStatement(sql);			
			pstmt.setString(1, encodeData(vo.getTitle()));
			pstmt.setString(2, encodeData(vo.getUserName()));
			pstmt.setString(3, encodeData(vo.getPassword()));
			pstmt.setString(4, encodeData(vo.getMemo()));			
			pstmt.setInt(5, idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt);
		}
	}
	
	/* �Խñ� �����ϱ� */
	public void deletePost(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			sql = "delete from BOARD_TB where BOARDIDX=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt);
		}
	}

	/* �Խñ� ��й�ȣ Ȯ�� */
	public boolean checkPassword(int idx, String pwd) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean chk = false;
		try {
			sql = "select BOARDIDX FROM BOARD_TB where BOARDIDX=? and PASSWORD=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if (rs.next()) { // ������� ������ ��й�ȣ �´� ���
				chk = true;
			} else { // ��й�ȣ Ʋ�� ���
				chk = false;
			}
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt, rs);
		}
		return chk;
	}
}