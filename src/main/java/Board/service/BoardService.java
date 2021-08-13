package Board.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import Board.dto.Board;
import Board.dto.BoardFile;
import Board.dto.Comments;
import Board.util.Paging;

public interface BoardService {

	public Paging getPaging(Paging inDate);

	public List<HashMap<String, Object>> list(Paging paging);

	public void insertfile(Board board, List<MultipartFile> fileList);

	public HashMap<String, Object> view(Board board);

	public List<BoardFile> getFiles(Board board);

	public void delete(Board board);

	public void deletefile(Board board);

	public Board getViewForUpdate(Board board);


	public BoardFile getFile(BoardFile boardfile);

	public void updateBoardAndFiles(Board board, List<MultipartFile> flist);

	public void deleteOldFile(String[] oldFile);

	public List<HashMap<String, Object>> getCommentList(Board board);

	public void insertComments(Comments comments);

	public HashMap<String, Object> getCommentForUpdate(Comments comments);

	public HashMap<String, Object> getComments(Comments comments);

	public void updateComments(Comments comments);

	public void deleteComments(Comments comments);







}
