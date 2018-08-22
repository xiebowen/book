package org.xie.book.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xie.book.domain.Book;
import org.xie.book.service.BookService;

import com.github.pagehelper.PageInfo;



@Controller
@RequestMapping("/books")

/********
 * 
 * @author 解博文
 * 控制层
 */
public class BookController {
	
	@Autowired
	private BookService bookService;
	
	
	//查询所有书籍
	@RequestMapping("/list")
	@ResponseBody
	public PageInfo<Book> getBookList(Integer pageNum){
		
		return bookService.getAllBook(pageNum);
		
	}

	//保存书籍
	@RequestMapping("/save")
	@ResponseBody
	public String saveBook(Book book){
		try {
			bookService.saveBook(book);
			return "ok";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}	
	
	//删除书籍
	@RequestMapping("/del")
	@ResponseBody
	public String delBook(Book book){
		try {
			bookService.delBook(book);
			return "ok";
		} catch (Exception e) {
			return "error";
		}

	}		
	
}
