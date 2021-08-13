package Board.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import Board.dto.Board;
import Board.dto.BoardFile;
import Board.dto.Comments;
import Board.util.Paging;

public interface BoardDao {

	public int selectCntAll(Paging inDate);

	public List<HashMap<String, Object>> selectPageList(Paging paging);

	public void insertBoard(Board board);

	public void insertBoardFiles(BoardFile bf);

	public HashMap<String, Object> selectView(Board board);

	public List<BoardFile> selectBygetFile(Board board);

	public void deleteBoard(Board board);

	public void deleteBoardFile(Board board);

	public Board selectOneByBoardno(Board board);


	public BoardFile selectByFileno(BoardFile boardfile);

	public void upateBoard(Board board);

	public void insertnewBoardFile(BoardFile bf);

	public void delteFileno(MultipartFile bffileNo);

	public void deleteOldFile(int bfNo);

	public List<HashMap<String, Object>> selectBycomment(Board board);

	public void insertComments(Comments comments);

	public HashMap<String, Object> selectCmt(Comments comments);

	public HashMap<String, Object> selectOneComments(Comments comments);

	public void updateComments(Comments comments);

	public void deleteComments(Comments comments);




}
