package com.vp.board;

import java.io.UnsupportedEncodingException;
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

	/* �Խù� �� ���� */
	public int countList() {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null; // �����ϵ� SQL���� DBMS�� ����
		ResultSet rs = null;
		int cnt = 0;
		try {
			sql = "SELECT COUNT(*) FROM BOARD_TB";
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

	/* ��Ϻ��� */
	public ArrayList<BoardVO> getList(String keyField, String keyWord) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardVO> alist = new ArrayList<BoardVO>();
		try {
			sql = "SELECT BOARDIDX,USERNAME,TITLE,HIT,CREATEAT FROM BOARD_TB ";
			
			if(keyWord != null && !keyWord.equals("") ){
//				[iso-8859-1,euc-kr] = �׽�Ʈ
//						[iso-8859-1,ksc5601] = �׽�Ʈ
				String str = new String(keyWord.trim().getBytes("iso-8859-1"), "euc-kr");
                sql +="WHERE "+keyField.trim()+" LIKE '%"+ str +"%' ORDER BY BOARDIDX DESC";
                System.out.println(sql);
            }else{
                sql +="ORDER BY BOARDIDX DESC";
            }
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardVO vo = new BoardVO();
				vo.setBoardIdx(rs.getInt(1));
				vo.setUserName(rs.getString(2));
				vo.setTitle(rs.getString(3));
				vo.setHit(rs.getInt(4));
				vo.setCreateAt(rs.getString(5));

				// boolean dayNew = false;
				// Date = new Date();
				// SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
				// String year = (String) simpleDate.format(date);
				// String yea = rs.getString(4).substring(0, 10);
				// if (year.equals(yea)) {
				// dayNew = true;
				// }
				// vo.setTime(yea);

				alist.add(vo);
			}
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt, rs);
		}
		return alist;
	}

	// ��ȸ�� ����
	public void updateHit(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			sql = "UPDATE BOARD_TB SET HIT=HIT+1 where BOARDIDX=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt);
		}
	}

	// ���ñ� ���� ��������
	public BoardVO getWriteInfo(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardVO vo = null;

		try {
			sql = "SELECT USERNAME,TITLE,MEMO,HIT,CREATEAT FROM BOARD_TB WHERE BOARDIDX=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
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

	// �ۼ��ϱ�
	public void insertWrite(BoardVO vo) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			sql = "INSERT INTO BOARD_TB(BOARDIDX,USERNAME,PASSWORD,TITLE,MEMO) VALUES(BOARDIDX_SEQ.NEXTVAL,?,?,?,?)";
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

	// �����ϱ�
	public void modifyWrite(BoardVO vo, int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			sql = "UPDATE BOARD_TB SET TITLE=?,USERNAME=?,PASSWORD=?,MEMO=? WHERE BOARDIDX=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, encodeData(vo.getUserName()));
			pstmt.setString(2, encodeData(vo.getPassword()));
			pstmt.setString(3, encodeData(vo.getTitle()));
			pstmt.setString(4, encodeData(vo.getMemo()));
			pstmt.setInt(5, idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt);
		}
	}

	// ��й�ȣ üũ
	public boolean checkPassword(int idx, String pwd) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean ch = false;
		try {
			sql = "SELECT BOARDIDX FROM BOARD_TB WHERE BOARDIDX=? AND PASSWORD=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ch = true;
			} else {
				ch = false;
			}
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt, rs);
		}
		return ch;
	}

	// �����ϱ�
	public void deleteWrite(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			sql = "DELETE FROM BOARD_TB WHERE BOARDIDX=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt);
		}
	}
}