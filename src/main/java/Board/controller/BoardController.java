package Board.controller;

import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import Board.dto.Board;
import Board.dto.BoardFile;
import Board.dto.Comments;
import Board.service.BoardService;
import Board.util.Paging;


@Controller
@RequestMapping(value="/board")
public class BoardController {
private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired private BoardService boardService;
	
	@RequestMapping(value="/list")
	public void list(
			@RequestParam(value="curPage", defaultValue="0") int curPage, 
			@RequestParam(value="search", defaultValue="") String search, 
			@RequestParam(value="category", defaultValue="") String category, 
			Model model
			) {
		logger.info("/board/list [GET]");
		logger.info("search값 확인 {} :", search);
		logger.info("category값 확인 {} :", category);

		
		Paging inDate = new Paging();
		
		inDate.setCategory(category);
		inDate.setSearch(search);
		inDate.setCurPage(curPage);

		//페이징 계산
		Paging paging = boardService.getPaging(inDate);
		
		logger.info("paging값 확인 {} :", paging);
		
		//검색 포함한 페이징 계산	
		paging.setSearch(inDate.getSearch());
		paging.setCategory(inDate.getCategory());
		
		logger.info("inDate값 확인 {} :", inDate);
		
	    //해시맵으로 게시글 목록 조회
	    List <HashMap<String, Object>> list = boardService.list(paging);
	    logger.info("게시긂 목록 조회 확인  {} :" ,list);
	    
	   
		//모델값 전달
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
	}
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public void write() {
		logger.info("/write [GET]");
	}
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String writeProc(Board board, MultipartHttpServletRequest fileupload,Model model) {
		logger.info("/write [POST]");
		logger.info("boarfile {} " ,fileupload);
		//얻어온 다중 파일 리스트에 담기 - 완료
		List<MultipartFile> fileList = fileupload.getFiles("file");
		
		//파일첨부
		boardService.insertfile(board, fileList);
		logger.info("board안에 값 확인하기 : {}, board");
		
		model.addAttribute("Board", board);
		return "redirect:/board/list";
		
	}
	@RequestMapping(value="/download")
	public String download(BoardFile boardfile, Model model) {
		
		BoardFile fileupload = boardService.getFile(boardfile);	
		logger.info("다운로드 파일확인 {} :" ,fileupload);
		//모델값 전달
		model.addAttribute("downFile", fileupload);
		
		//viewName 지정하기
		return "down";
		
				
	}
	@RequestMapping(value="/view")
    public void view(Board board, Model model) {
    	logger.info("/baord/view [GET]");
    	logger.info("게시판에 포함된 key,value값 확인 : {}",board );
    	
    	
    	//상세 보여주기
    	HashMap<String, Object> detail = boardService.view(board);
    	logger.info("detail에 포함된 값 보기 : {}", detail);
    	logger.info("board에포함된 값 보기 : {}" , board);
    	
    	//첨부파일 리스트 얻어오기
    	List<BoardFile> viewfile = boardService.getFiles(board);
    	logger.info("viewfile에 포함된 값 보기 : {}", viewfile);
    	
    	//댓글 리스트 불러오기
    	List<HashMap<String, Object>> commentList = boardService.getCommentList(board);
    	
    	
    	//모델값 전달
    	model.addAttribute("detail", detail);
    	model.addAttribute("viewfile",viewfile);
    	model.addAttribute("commentList", commentList);
    }
	@RequestMapping(value="/delete")
	public String delete(Board board,BoardFile boardfile) {
	   logger.info("delete [GET]");
	   logger.info("boardno 확인 {}" , board);
	   
	   //게시판 글 지우기
	   boardService.delete(board);
	   //게시판 boardfile 지우기
	   logger.info("delefile 확인 {}",boardfile );
	   boardService.deletefile(board);
	   
	   
	   return "redirect:/board/list";
	}
	
	
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String updateForm(Board board, Model model ) {
		logger.info("/board/update [GET]");
		logger.info("얻어온 board값 확인 : {}", board);
		//게시글 상세보기
		Board boards = boardService.getViewForUpdate(board);
		
		logger.info("얻어온 board 전체 정보 확인 : {}", boards);
		
		//model값으로 공지사항 객체 설정
		model.addAttribute("boards", boards);
		
		//해당 게시글의 첨부파일 불러오기
		List<BoardFile> flist = boardService.getFiles(board);
		
		//model값으로 첨부파일 리스트 설정
		model.addAttribute("flist", flist);
		
		//viewName 설정
		return "/board/update";
	}
	@RequestMapping(value="/update")
	public String update( Board board,HttpServletRequest request, MultipartHttpServletRequest mtfRequest) {
		logger.info("얻어온 board객체 정보 확인 {}", board);
		
		String[] oldFile = request.getParameterValues("bfFileno");
		if(oldFile !=null) {
			boardService.deleteOldFile(oldFile);
		}
		
		//다중 첨부파일 리스트로 변환
		List<MultipartFile> flist = mtfRequest.getFiles("file");
		
		for( MultipartFile i : flist ) {
			logger.info("각각의 다중 첨부파일 정보 확인 {}", i);
		}
		
				
		
		//글 수정 메소드 호출
		boardService.updateBoardAndFiles(board, flist);
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/comments/insert")
	public String comments(Comments comments,Board board,Model model) {
		
		logger.info("/comments/insert [POST]");
		logger.info("comments 에있는 정보 {}:" , comments);

		boardService.insertComments(comments);
		
		//댓글 리스트 불러오기
    	List<HashMap<String, Object>> commentList = boardService.getCommentList(board);
    	model.addAttribute("commentList", commentList);
		
		logger.info("comments 내용 불러오기 : {}",comments);
		
		return "comments/cmtinsert";
	}
	@RequestMapping(value="/comments/update", method=RequestMethod.GET)
	public String CmtUpdateForm(Comments comments, Board board,Model model) {
		//해당 댓글 번호의 전체 정보 얻어오기
		HashMap<String, Object> comment = boardService.getCommentForUpdate(comments);
		
		//model값으로 해당 댓글 정보 설정
		model.addAttribute("cmt", comment);
		
		//댓글 리스트 불러오기
    	List<HashMap<String, Object>> commentList = boardService.getCommentList(board);
    	model.addAttribute("commentList", commentList);
		
		return "comments/updateForm";
	}
	@RequestMapping(value="/comments/updateCancel", method=RequestMethod.GET)
	public String CmtUpdateCancel(Comments comments, Model model) {
		logger.info("댓글 수정 취소 시 얻어온 데이터 : {}", comments);
		
		HashMap<String, Object> cmtcan = boardService.getComments(comments);
		
		model.addAttribute("cmtcan", cmtcan);
		
		return "comments/UpdateCancel";
	}
	@RequestMapping(value="/comments/update", method=RequestMethod.POST)
	public String CmtUpdate(Comments comments, Model model,Board board) {
		//입력받은 값을 기존의 댓글 번호에 덮어씌우기
		boardService.updateComments(comments);
		
		
		List<HashMap<String, Object>> commentList = boardService.getCommentList(board);
		model.addAttribute("commentList", commentList);


		return "comments/cmtUpdate";
	}
	@RequestMapping(value="/comments/delete")
	public String commentsDelete(Comments comments,Model model,Board board) {
		logger.info("/comments/delete [GET]");
		logger.info("commetns 안에 값 확인 : {}",comments);
		
	 boardService.deleteComments(comments);
		
	 List<HashMap<String, Object>> commentList = boardService.getCommentList(board);
	 model.addAttribute("commentList", commentList);
	 
	 return "comments/cmtDelete";
	}
}
