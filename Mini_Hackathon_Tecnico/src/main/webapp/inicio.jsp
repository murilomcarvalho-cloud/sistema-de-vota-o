<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.senai.service.TrilhaService" %>
<%@ page import="com.senai.model.Trilha" %>
<%@ page import="java.util.List" %>
<%
    List<Trilha> trilhas = TrilhaService.getInstance().getTrilhas();
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mundo SENAI - Conheça as Trilhas</title>
    <style>
        :root { font-family: 'Segoe UI', Helvetica, Arial, sans-serif; color: #243447; background: #F2F6FB; }
        * { box-sizing: border-box; }
        body { min-height: 100vh; margin: 0; padding: 28px 20px; background: radial-gradient(ellipse at top, #E4F1FC 0, #F2F6FB 54%, #F7F9FC 100%); }
        .container { max-width: 1040px; margin: 0 auto; padding: 26px 38px 28px; background: #FFFFFF; border: 1px solid #E5ECF3; border-top: 5px solid #005CA9; border-radius: 16px; box-shadow: 0 18px 55px rgba(25, 60, 95, .10); }
        .topbar { display: flex; justify-content: space-between; align-items: center; gap: 16px; margin-bottom: 30px; }
        .brand { color: #005CA9; font-size: 17px; font-weight: 900; letter-spacing: 1.5px; }
        .theme-options { display: inline-flex; gap: 8px; }
        .theme-button { min-width: 94px; padding: 9px 13px; color: #005CA9; background: #FFFFFF; border: 1px solid #B9CCDD; border-radius: 8px; cursor: pointer; font-size: 13px; font-weight: 700; }
        .theme-button:hover { background: #F1F7FC; border-color: #005CA9; }
        .theme-button[aria-pressed="true"] { color: #FFFFFF; background: #005CA9; border-color: #005CA9; }
        .hero { padding: 32px 20px 38px; text-align: center; }
        .eyebrow { margin: 0 0 11px; color: #005CA9; font-size: 11px; font-weight: 800; letter-spacing: 1.8px; text-transform: uppercase; }
        h1 { max-width: 720px; margin: 0 auto; color: #19324A; font-size: clamp(30px, 5vw, 46px); line-height: 1.12; letter-spacing: -1px; }
        .subtitle { max-width: 650px; margin: 16px auto 24px; color: #66788A; font-size: 16px; line-height: 1.7; }
        .primary-button { display: inline-flex; align-items: center; justify-content: center; min-height: 48px; padding: 12px 21px; color: #FFFFFF; background: #005CA9; border: 1px solid #005CA9; border-radius: 8px; text-decoration: none; font-size: 14px; font-weight: 800; transition: background .2s, transform .2s; }
        .primary-button:hover { background: #004480; transform: translateY(-1px); }
        .section-heading { display: flex; justify-content: space-between; align-items: baseline; gap: 16px; margin: 18px 0 16px; }
        .section-heading h2 { margin: 0; color: #243447; font-size: 22px; }
        .section-heading span { color: #718096; font-size: 13px; }
        .course-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 18px; }
        .course-card { overflow: hidden; background: #FFFFFF; border: 1px solid #E2EAF1; border-radius: 13px; box-shadow: 0 5px 18px rgba(25, 60, 95, .05); transition: transform .2s, box-shadow .2s, border-color .2s; }
        .course-card:hover { transform: translateY(-3px); border-color: #B7D0E4; box-shadow: 0 12px 26px rgba(25, 60, 95, .10); }
        .course-image { display: block; width: 100%; height: 190px; object-fit: cover; background: #DCEAF5; }
        .course-content { padding: 20px; }
        .course-content h3 { margin: 0 0 9px; color: #005CA9; font-size: 19px; }
        .course-description { margin: 0 0 16px; color: #586B7F; font-size: 14px; line-height: 1.65; }
        .detail-title { margin: 0 0 8px; color: #32495F; font-size: 12px; font-weight: 800; letter-spacing: .5px; text-transform: uppercase; }
        .detail-list { display: grid; gap: 7px; margin: 0; padding: 0; list-style: none; }
        .detail-list li { position: relative; padding-left: 18px; color: #617286; font-size: 13px; line-height: 1.45; }
        .detail-list li:before { position: absolute; left: 0; color: #1682C5; content: "✓"; font-weight: 800; }
        .footer-nav { display: flex; flex-wrap: wrap; justify-content: center; gap: 10px; margin-top: 28px; padding-top: 22px; border-top: 1px solid #E8EDF2; }
        .page-button { display: inline-flex; align-items: center; justify-content: center; min-height: 44px; padding: 10px 16px; color: #005CA9; background: #FFFFFF; border: 1px solid #B9CCDD; border-radius: 8px; text-decoration: none; font-size: 13px; font-weight: 700; }
        .page-button:hover { background: #F1F7FC; border-color: #005CA9; }
        .page-button[aria-current="page"] { color: #FFFFFF; background: #005CA9; border-color: #005CA9; }
        .theme-button:focus-visible, .primary-button:focus-visible, .page-button:focus-visible { outline: 3px solid #63B3ED; outline-offset: 3px; }
        html.dark-mode { color-scheme: dark; }
        html.dark-mode body { color: #E2E8F0; background: radial-gradient(ellipse at top, #20354A 0, #1A202C 55%, #171C25 100%); }
        html.dark-mode .container { background: #252F3D; border-color: #3A4655; box-shadow: 0 18px 55px rgba(0, 0, 0, .25); }
        html.dark-mode .brand, html.dark-mode .eyebrow, html.dark-mode .course-content h3 { color: #7CC4F4; }
        html.dark-mode h1, html.dark-mode .section-heading h2 { color: #F0F5FA; }
        html.dark-mode .subtitle, html.dark-mode .section-heading span, html.dark-mode .course-description, html.dark-mode .detail-list li { color: #B0BDCA; }
        html.dark-mode .theme-button, html.dark-mode .page-button { color: #90CDF4; background: #1D2733; border-color: #526174; }
        html.dark-mode .theme-button:hover, html.dark-mode .page-button:hover { background: #344154; border-color: #90CDF4; }
        html.dark-mode .theme-button[aria-pressed="true"], html.dark-mode .page-button[aria-current="page"] { color: #14202B; background: #90CDF4; border-color: #90CDF4; }
        html.dark-mode .primary-button { color: #14202B; background: #90CDF4; border-color: #90CDF4; }
        html.dark-mode .primary-button:hover { background: #63B3ED; }
        html.dark-mode .course-card { background: #1D2733; border-color: #3A4655; box-shadow: 0 5px 18px rgba(0, 0, 0, .12); }
        html.dark-mode .course-card:hover { border-color: #5D8FB7; }
        html.dark-mode .course-image { background: #354354; }
        html.dark-mode .detail-title { color: #D6E0EA; }
        html.dark-mode .detail-list li:before { color: #7CC4F4; }
        html.dark-mode .footer-nav { border-top-color: #3A4655; }
        @media (max-width: 700px) {
            body { padding: 14px 12px; }
            .container { padding: 18px 17px 20px; border-radius: 13px; }
            .topbar { margin-bottom: 14px; }
            .hero { padding: 26px 5px 30px; }
            .course-grid { grid-template-columns: 1fr; }
            .course-image { height: 210px; }
        }
        @media (max-width: 380px) {
            .topbar { align-items: flex-start; flex-direction: column; }
            .theme-button { min-width: 88px; }
            .section-heading { align-items: flex-start; flex-direction: column; gap: 5px; }
        }
    </style>
    <script>
        try {
            if (localStorage.getItem("theme") === "dark") {
                document.documentElement.classList.add("dark-mode");
            }
        } catch (error) {
        }
    </script>
</head>
<body>
    <main class="container">
        <nav class="topbar" aria-label="Navegação principal">
            <span class="brand">MUNDO SENAI</span>
            <div class="theme-options" role="group" aria-label="Escolha do tema">
                <button type="button" class="theme-button" id="light-theme" aria-pressed="true">☀ Claro</button>
                <button type="button" class="theme-button" id="dark-theme" aria-pressed="false">☾ Escuro</button>
            </div>
        </nav>
        <header class="hero">
            <p class="eyebrow">Tecnologia · Educação · Futuro</p>
            <h1>Descubra a trilha que combina com você</h1>
            <p class="subtitle">Explore as áreas de tecnologia, conheça o que você pode aprender e escolha qual delas gostaria de seguir.</p>
            <a class="primary-button" href="index.jsp?votar=1">Conhecer opções e votar <span aria-hidden="true">&nbsp;→</span></a>
        </header>

        <section aria-labelledby="courses-heading">
            <div class="section-heading">
                <h2 id="courses-heading">Conheça as trilhas</h2>
                <span><%= trilhas.size() %> áreas para explorar</span>
            </div>
            <div class="course-grid">
                <% for (Trilha trilha : trilhas) {
                    String imagem = "";
                    String textoImagem = trilha.getNome();
                    String[] detalhes = new String[3];
                    switch (trilha.getId()) {
                        case 1:
                            imagem = "https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&w=1000&q=80";
                            textoImagem = "Visualização abstrata de inteligência artificial";
                            detalhes = new String[] {"Aprenda conceitos de dados e aprendizado de máquina", "Explore como redes neurais identificam padrões", "Crie soluções inteligentes com programação"};
                            break;
                        case 2:
                            imagem = "https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=1000&q=80";
                            textoImagem = "Estação de trabalho para desenvolvimento de software";
                            detalhes = new String[] {"Desenvolva interfaces para sites e aplicações", "Conheça APIs, bancos de dados e serviços em nuvem", "Pratique a construção de sistemas completos"};
                            break;
                        case 3:
                            imagem = "https://images.unsplash.com/photo-1485827404703-89b55fcc595e?auto=format&fit=crop&w=1000&q=80";
                            textoImagem = "Robô em ambiente de laboratório";
                            detalhes = new String[] {"Programe robôs e sistemas automatizados", "Integre sensores, eletrônica e microcontroladores", "Descubra aplicações de IoT e indústria 4.0"};
                            break;
                        case 4:
                            imagem = "https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&w=1000&q=80";
                            textoImagem = "Representação de segurança digital e redes";
                            detalhes = new String[] {"Entenda proteção de redes, sistemas e dados", "Aprenda monitoramento e resposta a incidentes", "Pratique segurança digital de forma ética e defensiva"};
                            break;
                        default:
                            imagem = "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=1000&q=80";
                            detalhes = new String[] {"Conheça fundamentos e ferramentas da área", "Desenvolva habilidades com projetos práticos", "Explore possibilidades de carreira em tecnologia"};
                    }
                %>
                    <article class="course-card">
                        <img class="course-image" src="<%= imagem %>" alt="<%= textoImagem %>" loading="lazy">
                        <div class="course-content">
                            <h3><%= trilha.getNome() %></h3>
                            <p class="course-description"><%= trilha.getDescricao() %>. Esta trilha apresenta conceitos e práticas para você começar a explorar essa área da tecnologia.</p>
                            <h4 class="detail-title">O que você pode explorar</h4>
                            <ul class="detail-list">
                                <% for (String detalhe : detalhes) { %>
                                    <li><%= detalhe %></li>
                                <% } %>
                            </ul>
                        </div>
                    </article>
                <% } %>
            </div>
        </section>

        <nav class="footer-nav" aria-label="Navegação entre páginas">
            <a class="page-button" href="inicio.jsp" aria-current="page">ℹ️ Conheça as trilhas</a>
            <a class="page-button" href="index.jsp?votar=1">🗳️ Votação</a>
            <a class="page-button" href="resultado.jsp">🏆 Ranking</a>
            <a class="page-button" href="resultado-graficos.jsp">📈 Gráficos</a>
        </nav>
    </main>
    <script>
        (function() {
            var lightButton = document.getElementById("light-theme");
            var darkButton = document.getElementById("dark-theme");

            function setTheme(isDark) {
                document.documentElement.classList.toggle("dark-mode", isDark);
                lightButton.setAttribute("aria-pressed", String(!isDark));
                darkButton.setAttribute("aria-pressed", String(isDark));
                try {
                    localStorage.setItem("theme", isDark ? "dark" : "light");
                } catch (error) {
                }
            }

            setTheme(document.documentElement.classList.contains("dark-mode"));
            lightButton.addEventListener("click", function() { setTheme(false); });
            darkButton.addEventListener("click", function() { setTheme(true); });
        })();
    </script>
</body>
</html>
