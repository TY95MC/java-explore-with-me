package ru.practicum.comment.model;

import org.mapstruct.Mapper;
import ru.practicum.comment.model.dto.CommentDto;
import ru.practicum.comment.model.dto.NewCommentDto;
import ru.practicum.comment.model.dto.ShortCommentDto;

@Mapper(componentModel = "spring")
public interface CommentMapper {
    Comment mapNewCommentDtoToComment(NewCommentDto dto);

    CommentDto mapCommentToCommentDto(Comment comment);

    ShortCommentDto mapCommentToShortCommentDto(Comment comment);
}
