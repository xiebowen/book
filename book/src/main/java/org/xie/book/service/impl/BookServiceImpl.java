package org.xie.book.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xie.book.domain.Book;
import org.xie.book.mapper.BookMapper;
import org.xie.book.service.BookService;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
/********
 * 
 * @author 解博文
 * 业务实现类
 */
@Service
public class BookServiceImpl implements BookService {

	@Autowired
	private BookMapper bookMapper;
	
	
	//查询所有书籍
	public PageInfo<Book> getAllBook(Integer pageNum) {
		
		PageHelper.startPage(pageNum, 5);
		List<Book>list = bookMapper.selectAllBook();
		PageInfo<Book> page = new PageInfo<>(list);
		
		return page;
	}


	//添加书籍
	public void saveBook(Book book) {
		if(book!=null){
			if(book.getId()!=null){
				//修改书籍信息
				bookMapper.updateBookById(book);
			}else{
				//添加书籍信息
				bookMapper.insertBook(book);
			}
			
			
		}

	}

	//删除书籍
	public void delBook(Book book) {
		if(book!=null){
			if(book.getId()!=null){
				bookMapper.deleteBook(book);
			}
		}
		
	}

}
