package com.example.musicemotion.artist.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.ArtistDTO;

@Service
public class ArtistService {

    @Autowired
    private SqlSession sqlSession;

    public boolean addArtist(ArtistDTO dto) {
        try {
            sqlSession.insert("addArtist", dto);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<ArtistDTO> artistAll(String user_id) {
        return sqlSession.selectList("artistAll", user_id);
    }
    
    public List<String> artistId(ArtistDTO dto) {
        return sqlSession.selectList("artistId", dto);
    }
    
    public List<String> artistIdAll(String user_id) {
        return sqlSession.selectList("artistIdAll", user_id);
    }

    public void updateArtist(ArtistDTO dto) {
        sqlSession.update("updateArtist", dto);
    }

    public boolean deleteArtist(ArtistDTO dto) {
        try {
            sqlSession.delete("deleteArtist", dto);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public ArtistDTO getArtistById(String artist_id) {
    	return sqlSession.selectOne("getArtistById",artist_id);
    }
}
