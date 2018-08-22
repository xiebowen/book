package org.xie.book.service;


import org.xie.book.domain.Book;

import com.github.pagehelper.PageInfo;
/******
 * 
 * @author 解博文
 *	业务接口
 */
public interface BookService {
	
	
	//查询所有书籍
	public PageInfo<Book> getAllBook(Integer pageNum);	
	//保存书籍（添加和修改）
	public void saveBook(Book book);		
	//删除书籍
	public void delBook(Book book);	
}
