package org.zerock.util.weather;

import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

// 기상청 초단기예보를 XML로 요청해서 받아오는 프로그램
// 마두 2동, 정발 1동, 정발2동 x: 56, 128
// 현재시간이 예) 10시 29분까지 -> 10시예보, 10시 30분부터 -> 11시 예보
public class WeatherXML {

	public static String getWeatherXML (int x, int y, String[] v) {
		
		// java.net
		HttpURLConnection con = null;
		String err = null; // Error Message
		String serviceKey = "Ehjq4awcfX7gm165%2F4MJ7jK1FLlIq%2Bs1gqvv3ozV0qgvKuScqjgBajfUDLP1SuAK%2FnFxyfgZ4zZ3U87N%2F6hQWQ%3D%3D";
		
		try {
			// java.net
			// 현재시간에서 30분전
			LocalDateTime dateTime = LocalDateTime.now().minusMinutes(30);
			//java.net
			// nx=56&ny=128
			URL url = new URL("https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst"
					+ "?serviceKey=" + serviceKey
					+ "&pageNo=1&numOfRows=1000&dataType=XML"
					+ "&base_date=" + dateTime.format(DateTimeFormatter.ofPattern("yyyyMMdd"))
					+ "&base_time=" + dateTime.format(DateTimeFormatter.ofPattern("HHmm"))
					+ "&nx=" + x
					+ "&ny=" + y
					);
			
			con = (HttpURLConnection) url.openConnection();
			
			// org.w3c.dom -> HTML, XML과 관련된 패키지
			// Document = HTML, XML 문서를 의미
			// HTML요소(tag)와 관련된 작업을 도와줍니다.
			Document doc = DocumentBuilderFactory
					.newInstance().newDocumentBuilder()
					.parse(con.getInputStream());
			
			boolean ok = false;
			Element e;
			NodeList ns = doc.getElementsByTagName("header");
			if (ns.getLength() > 0) {
				e = (Element) ns.item(0);
				if ("00".equals(e.getElementsByTagName("resultCode").item(0).getTextContent()))
					ok = true;
				else
					err = e.getElementsByTagName("resultMsg").item(0).getTextContent();
			}
			
			if (ok) {
				String fd = null, ft = null; // 가장 빠른 예보날짜, 예보시간
				String pty = null; // 강수형태
				String sky = null; // 하늘상태
				String cat; // category
				String val; // fcstValue
				
				ns = doc.getElementsByTagName("item");
				for (int i = 0; i < ns.getLength(); i++) {
					e = (Element) ns.item(i);
					
					if (ft == null) {
						// 화면에 표시할 시간정보를 저장
						fd = e.getElementsByTagName("fcstDate").item(0).getTextContent();
						ft = e.getElementsByTagName("fcstTime").item(0).getTextContent();
					}
					else if (
							!fd.equals(e.getElementsByTagName("fcstDate").item(0).getTextContent())
							|| !ft.equals(e.getElementsByTagName("fcstTime").item(0).getTextContent())
							) 
					{
						continue;
					}
					
					cat = e.getElementsByTagName("category").item(0).getTextContent();
					val = e.getElementsByTagName("fcstValue").item(0).getTextContent();
					
					if ("PTY".equals(cat)) pty = val; // 강수형태
					else if ("SKY".equals(cat)) sky = val; // 하늘상태
					else if ("T1H".equals(cat)) v[3] = val; // 기온
					else if ("REH".equals(cat)) v[4] = val; // 습도
				} // end of for()
				
				v[0] = fd; // 날짜
				v[1] = ft; // 시간
				
				if ("0".equals(pty)) {
					// 강수형태가 없는 경우, 하늘상태로 판단
					if ("1".equals(sky)) v[2] = "맑음";
					else if ("3".equals(sky)) v[2] = "구름많음";
					else if ("4".equals(sky)) v[2] = "흐림";
				}
				else if ("1".equals(pty)) v[2] = "비";
				else if ("2".equals(pty)) v[2] = "비/눈";
				else if ("3".equals(pty)) v[2] = "눈";
				else if ("5".equals(pty)) v[2] = "빗방울";
				else if ("6".equals(pty)) v[2] = "빗방울눈날림";
				else if ("7".equals(pty)) v[2] = "눈날림";
			}
		} catch (Exception e) {
			// TODO: handle exception
			err = e.getMessage();
		} finally {
			if (con != null) con.disconnect();
		}
		
		return err;
	}
}
