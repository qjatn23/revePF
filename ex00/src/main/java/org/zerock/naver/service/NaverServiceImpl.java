package org.zerock.naver.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.zerock.naver.vo.NaverUser;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class NaverServiceImpl implements NaverService {

    private static final String CLIENT_ID = "Ge_8IR6KHMov_RVNL60u"; // 네이버 Client ID
    private static final String CLIENT_SECRET = "k3sIIrn8_U"; // 네이버 Client Secret
    private static final String TOKEN_URL = "https://nid.naver.com/oauth2.0/token"; // 토큰 요청 URL
    private static final String USER_INFO_URL = "https://openapi.naver.com/v1/nid/me"; // 사용자 정보 요청 URL

    // 네이버 인증 코드로 Access Token 요청
    @Override
    public String getAccessToken(String code, String state) throws Exception {
        // 인증 코드와 state 값을 포함한 URL 생성
        String tokenRequestUrl = TOKEN_URL + "?grant_type=authorization_code"
                + "&client_id=" + CLIENT_ID
                + "&client_secret=" + CLIENT_SECRET
                + "&code=" + code
                + "&state=" + state;

        // 네이버 API 호출
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(tokenRequestUrl, String.class);

        // JSON 응답에서 Access Token 추출
        ObjectMapper mapper = new ObjectMapper();
        JsonNode rootNode = mapper.readTree(response.getBody());
        return rootNode.path("access_token").asText();
    }

    // Access Token으로 사용자 정보 조회
    @Override
    public NaverUser getUserInfo(String accessToken) throws Exception {
        // 헤더에 Access Token 추가
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);

        // HTTP 요청 생성 및 API 호출
        HttpEntity<String> entity = new HttpEntity<>(headers);
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(USER_INFO_URL, HttpMethod.GET, entity, String.class);

        // JSON 응답에서 사용자 정보 추출
        ObjectMapper mapper = new ObjectMapper();
        JsonNode rootNode = mapper.readTree(response.getBody());
        JsonNode responseNode = rootNode.path("response");

        // 사용자 정보 NaverUser 객체에 매핑
        NaverUser naverUser = new NaverUser();
        naverUser.setId(responseNode.path("id").asText());           // 네이버 ID
        naverUser.setNickname(responseNode.path("nickname").asText()); // 닉네임
        naverUser.setEmail(responseNode.path("email").asText());       // 이메일
        naverUser.setName(responseNode.path("name").asText());         // 이름
        naverUser.setGender(responseNode.path("gender").asText());     // 성별

        return naverUser;
    }
}
