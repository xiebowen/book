package org.xie.book.mapper;

import java.util.List;

import org.xie.book.domain.Book;

public interface BookMapper {
	
	//查询所有书籍
	public List<Book> selectAllBook();
	//添加书籍
	public void insertBook(Book book);	
	//修改书籍
	public void updateBookById(Book book);
	//删除书籍
	public void deleteBook(Book book);	
}
