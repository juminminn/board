package Board.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import Board.dao.BoardDao;
import Board.dto.Board;
import Board.dto.BoardFile;
import Board.dto.Comments;
import Board.util.Paging;


@Service
public class BoardServiceImpl implements BoardService {

private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);
	
	@Autowired private BoardDao boardDao;
	
	@Autowired ServletContext context;

	@Override
	public Paging getPaging(Paging inDate) {
		logger.info("inDate 값 확인 : {}",inDate);
		//총 게시글 수 조회
		int totalCount = boardDao.selectCntAll(inDate);
		
		//페이징 계산
		Paging paging = new Paging(totalCount,inDate.getCurPage());
		
		logger.info("paging안에 있는 값 확인 : {}",paging);
		
		return paging;
	}

	@Override
	public List<HashMap<String, Object>> list(Paging paging) {
		return boardDao.selectPageList(paging);
	}

	@Override
	public void insertfile(Board board, List<MultipartFile> fileList) {
		boardDao.insertBoard(board);
		
		logger.info("글작성후 board의 값 확인 : {}",board);
		
		//첨부파일 저장 수행
				String storedPath = context.getRealPath("resources/upload");
				
				File stored = new File(storedPath);
				if( !stored.exists() ) {
					stored.mkdir();
				}
				
				for( MultipartFile file : fileList ) {
					
					if( file.getSize() <= 0 ) {
						return;
					}
						
					String filename = file.getOriginalFilename();
						
					String uid = UUID.randomUUID().toString().split("-")[4];
					
					filename += uid;
					
					File dest = new File( stored, filename );
						
					try {
						file.transferTo(dest);
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
						
					BoardFile bf = new BoardFile();
					bf.setbNo(board.getbNo());
					bf.setBfOriginName(file.getOriginalFilename());
					bf.setBfStoredName( filename );
					bf.setBfSize((int) file.getSize());
					bf.setBfContentType(file.getContentType());
					
					
					boardDao.insertBoardFiles( bf );
					
				} // for문 end (다중 첨부파일)
		
	}

	@Override
	public HashMap<String, Object> view(Board board) {
		return boardDao.selectView(board);
	}

	@Override
	public List<BoardFile> getFiles(Board board) {
		return boardDao.selectBygetFile(board);
	}

	@Override
	public void delete(Board board) {
		boardDao.deleteBoard(board);	
	}

	@Override
	public void deletefile(Board board) {
		boardDao.deleteBoardFile(board);
	}

	@Override
	public BoardFile getFile(BoardFile boardfile) {
		return boardDao.selectByFileno(boardfile);
	}
	@Override
	public Board getViewForUpdate(Board board) {
		return boardDao.selectOneByBoardno(board);
	}


	@Override
	public void updateBoardAndFiles(Board board, List<MultipartFile> flist) {
		
		boardDao.upateBoard(board);
		
//		for(MultipartFile bffileNo : fileNo) {
//			
//			boardDao.delteFileno(bffileNo);
//		}
		
		logger.info("board안에 값 확인 :{}",board);
		
		
		
        String storedPath = context.getRealPath("resources/upload");
		
		File stored = new File(storedPath);
		if( !stored.exists() ) {
			stored.mkdir();
		}
		
		for( MultipartFile file : flist ) {
			
			if( file.getSize() <= 0 ) {
				return;
			}
			
			String filename = file.getOriginalFilename();
			
			String uid = UUID.randomUUID().toString().split("-")[4];
			
			filename += uid;
			
			File dest = new File( stored, filename );
				
			try {
				file.transferTo(dest);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
				
			BoardFile bf = new BoardFile();
			bf.setbNo(board.getbNo());
			bf.setBfOriginName(file.getOriginalFilename());
			bf.setBfStoredName( filename );
			bf.setBfSize((int) file.getSize());
			bf.setBfContentType(file.getContentType());	
			
			boardDao.insertnewBoardFile(bf);
	    }
	}

	@Override
	public void deleteOldFile(String[] oldFile) {
		for(String f : oldFile) {
			int bfNo = Integer.parseInt(f);
//			logger.info("삭제해야할 파일번호 : {}", bfNo);
			boardDao.deleteOldFile(bfNo);
		}
	}

	@Override
	public List<HashMap<String, Object>> getCommentList(Board board) {
		return boardDao.selectBycomment(board);
	}
	@Override
	public void insertComments(Comments comments) {
		boardDao.insertComments(comments);
	}

	@Override
	public HashMap<String, Object> getCommentForUpdate(Comments comments) {
		return boardDao.selectCmt(comments);
	}

	@Override
	public HashMap<String, Object> getComments(Comments comments) {
		return boardDao.selectOneComments(comments);
	}

	@Override
	public void updateComments(Comments comments) {
		boardDao.updateComments(comments);
	}

	@Override
	public void deleteComments(Comments comments) {
		boardDao.deleteComments(comments);
	}

	
	
	
}
