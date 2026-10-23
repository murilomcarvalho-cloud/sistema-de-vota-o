<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.senai.service.TrilhaService" %>
<%@ page import="com.senai.model.Trilha" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    TrilhaService service = TrilhaService.getInstance();
    List<Trilha> ranking = new ArrayList<>(service.getTrilhas());

    for (int i = 0; i < ranking.size() - 1; i++) {
        for (int j = 0; j < ranking.size() - 1 - i; j++) {
            if (ranking.get(j).getVotos() < ranking.get(j + 1).getVotos()) {
                Trilha aux = ranking.get(j);
                ranking.set(j, ranking.get(j + 1));
                ranking.set(j + 1, aux);
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="refresh" content="3">
    <title>Mundo SENAI - Resultados</title>
    <style>
        :root { font-family: 'Segoe UI', Arial, sans-serif; color: #243447; background: #F2F6FB; }
        * { box-sizing: border-box; }
        body { min-height: 100vh; margin: 0; padding: 32px 20px; background: radial-gradient(ellipse at top, #E4F1FC 0, #F2F6FB 54%, #F7F9FC 100%); }
        .container { max-width: 820px; margin: 0 auto; padding: 28px 38px 24px; background: #FFFFFF; border: 1px solid #E5ECF3; border-top: 5px solid #005CA9; border-radius: 16px; box-shadow: 0 18px 55px rgba(25, 60, 95, 0.10); }
        .topbar { display: flex; justify-content: center; align-items: center; gap: 12px; margin-bottom: 24px; }
        .theme-label { color: #526477; font-size: 13px; font-weight: 700; }
        .theme-options { display: inline-flex; gap: 8px; }
        .theme-button { min-width: 100px; padding: 10px 16px; color: #005CA9; background: #FFFFFF; border: 1px solid #B9CCDD; border-radius: 8px; cursor: pointer; font-size: 14px; font-weight: 700; transition: background .2s, color .2s, border-color .2s, box-shadow .2s; }
        .theme-button:hover { background: #F1F7FC; border-color: #005CA9; }
        .theme-button[aria-pressed="true"] { color: #FFFFFF; background: #005CA9; border-color: #005CA9; box-shadow: 0 3px 9px rgba(0, 92, 169, .2); }
        .hero { margin-bottom: 30px; text-align: center; }
        .header-logo { display: inline-flex; align-items: center; justify-content: center; min-width: 82px; padding: 8px 15px; color: #FFFFFF; background: #005CA9; border-radius: 7px; font-size: 18px; font-weight: 900; letter-spacing: 1.5px; }
        .eyebrow { margin: 20px 0 8px; color: #005CA9; font-size: 11px; font-weight: 800; letter-spacing: 1.8px; text-transform: uppercase; }
        h1 { margin: 0; color: #19324A; font-size: clamp(27px, 4vw, 35px); line-height: 1.2; letter-spacing: -.7px; }
        .subtitle { max-width: 500px; margin: 12px auto 17px; color: #66788A; font-size: 15px; line-height: 1.6; }
        .live-status { display: inline-flex; align-items: center; gap: 8px; padding: 7px 11px; color: #27745A; background: #E8F8F0; border: 1px solid #C8EBDD; border-radius: 999px; font-size: 11px; font-weight: 700; }
        .live-dot { width: 7px; height: 7px; background: #36A879; border-radius: 50%; box-shadow: 0 0 0 3px rgba(54, 168, 121, .13); }
        .ranking-heading { display: flex; justify-content: space-between; align-items: baseline; gap: 12px; margin: 0 0 12px; }
        .ranking-heading h2 { margin: 0; color: #243447; font-size: 17px; }
        .ranking-heading span { color: #718096; font-size: 12px; }
        .table-wrap { overflow: hidden; border: 1px solid #E4EAF0; border-radius: 11px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 15px 18px; font-size: 14px; border-bottom: 1px solid #E8EDF2; text-align: left; }
        th { color: #607286; background: #F7F9FC; font-size: 10px; font-weight: 800; letter-spacing: .9px; text-transform: uppercase; }
        tbody tr:last-child td { border-bottom: 0; }
        tbody tr { transition: background .2s; }
        tbody tr:hover { background: #F7FAFD; }
        .position-cell, .votes-cell { text-align: center; }
        .position-number { display: inline-flex; align-items: center; justify-content: center; min-width: 35px; height: 35px; color: #557087; background: #EFF4F8; border-radius: 50%; font-size: 13px; font-weight: 800; }
        .track-name { color: #2C4054; font-weight: 700; }
        .votos-badge { display: inline-block; min-width: 38px; padding: 6px 11px; color: #40566C; background: #EDF2F7; border-radius: 999px; font-size: 13px; font-weight: 800; }
        .primeiro-lugar { background: #FFFCF1; }
        .primeiro-lugar .position-number { color: #805A05; background: #F7D979; }
        .primeiro-lugar .track-name { color: #624A10; }
        .primeiro-lugar .votos-badge { color: #FFFFFF; background: #B78314; }
        .empty-state { padding: 28px 16px; color: #718096; text-align: center; }
        .footer-nav { display: flex; flex-wrap: wrap; justify-content: center; gap: 10px; margin-top: 24px; padding-top: 20px; border-top: 1px solid #E8EDF2; }
        .page-button { display: inline-flex; align-items: center; justify-content: center; min-height: 44px; padding: 10px 16px; color: #005CA9; background: #FFFFFF; border: 1px solid #B9CCDD; border-radius: 8px; text-decoration: none; font-size: 13px; font-weight: 700; transition: background .2s, color .2s, border-color .2s, transform .2s; }
        .page-button:hover { background: #F1F7FC; border-color: #005CA9; transform: translateY(-1px); }
        .page-button.primary { color: #FFFFFF; background: #005CA9; border-color: #005CA9; }
        .page-button.primary:hover { background: #004480; border-color: #004480; }
        .page-button[aria-current="page"] { color: #526477; background: #EDF2F7; border-color: #D6E1EC; cursor: default; }
        .theme-button:focus-visible, .page-button:focus-visible { outline: 3px solid #63B3ED; outline-offset: 3px; }
        html.dark-mode { color-scheme: dark; }
        html.dark-mode body { color: #E2E8F0; background: radial-gradient(ellipse at top, #20354A 0, #1A202C 55%, #171C25 100%); }
        html.dark-mode .container { background: #252F3D; border-color: #3A4655; box-shadow: 0 18px 55px rgba(0, 0, 0, .25); }
        html.dark-mode .header-logo { color: #FFFFFF; background: #1A6DB1; }
        html.dark-mode .eyebrow { color: #7CC4F4; }
        html.dark-mode h1, html.dark-mode .ranking-heading h2 { color: #F0F5FA; }
        html.dark-mode .subtitle, html.dark-mode .ranking-heading span { color: #B0BDCA; }
        html.dark-mode .theme-label { color: #B0BDCA; }
        html.dark-mode .theme-button { color: #90CDF4; background: #1D2733; border-color: #526174; }
        html.dark-mode .theme-button:hover { background: #344154; border-color: #90CDF4; }
        html.dark-mode .theme-button[aria-pressed="true"] { color: #14202B; background: #90CDF4; border-color: #90CDF4; box-shadow: 0 3px 9px rgba(0, 0, 0, .2); }
        html.dark-mode .live-status { color: #9AE6C5; background: #1D4642; border-color: #28655D; }
        html.dark-mode .live-dot { background: #57C798; }
        html.dark-mode .table-wrap { border-color: #3A4655; }
        html.dark-mode th { color: #B0BDCA; background: #1D2733; }
        html.dark-mode th, html.dark-mode td { border-bottom-color: #3A4655; }
        html.dark-mode tbody tr:hover { background: #2C3949; }
        html.dark-mode .position-number { color: #CBD5E0; background: #354354; }
        html.dark-mode .track-name { color: #E2E8F0; }
        html.dark-mode .votos-badge { color: #E2E8F0; background: #3A4655; }
        html.dark-mode .primeiro-lugar { background: #443A20; }
        html.dark-mode .primeiro-lugar .position-number { color: #553C05; background: #F7D979; }
        html.dark-mode .primeiro-lugar .track-name { color: #FDE68A; }
        html.dark-mode .primeiro-lugar .votos-badge { color: #FFFFFF; background: #B78314; }
        html.dark-mode .empty-state { color: #B0BDCA; }
        html.dark-mode .footer-nav { border-top-color: #3A4655; }
        html.dark-mode .page-button { color: #90CDF4; background: #1D2733; border-color: #526174; }
        html.dark-mode .page-button:hover { background: #344154; border-color: #90CDF4; }
        html.dark-mode .page-button.primary { color: #14202B; background: #90CDF4; border-color: #90CDF4; }
        html.dark-mode .page-button.primary:hover { background: #63B3ED; }
        html.dark-mode .page-button[aria-current="page"] { color: #B0BDCA; background: #354354; border-color: #526174; }
        @media (max-width: 600px) {
            body { padding: 14px 12px; }
            .container { padding: 20px 17px 18px; border-radius: 13px; }
            .hero { margin-bottom: 24px; }
            th, td { padding: 12px 10px; font-size: 13px; }
            th { font-size: 9px; }
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
    <div class="container">
        <div class="topbar">
            <span class="theme-label">Modo de exibição:</span>
            <div class="theme-options" role="group" aria-label="Escolha do tema">
                <button type="button" class="theme-button" id="light-theme" aria-pressed="true">☀ Claro</button>
                <button type="button" class="theme-button" id="dark-theme" aria-pressed="false">☾ Escuro</button>
            </div>
        </div>
        <header class="hero">
            <div class="header-logo">SENAI</div>
            <p class="eyebrow">Mundo SENAI · Tecnologia</p>
            <h1>Painel de resultados</h1>
            <p class="subtitle">Acompanhe em tempo real a popularidade das trilhas profissionais.</p>
            <span class="live-status"><span class="live-dot" aria-hidden="true"></span>Atualização automática</span>
        </header>

        <section aria-labelledby="ranking-title">
            <div class="ranking-heading">
                <h2 id="ranking-title">Ranking das trilhas</h2>
                <span><%= ranking.size() %> opções</span>
            </div>
            <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th class="position-cell" style="width: 20%;">Posição</th>
                    <th style="width: 55%;">Trilha</th>
                    <th class="votes-cell" style="width: 25%;">Votos</th>
                </tr>
            </thead>
            <tbody>
                <% if (ranking.isEmpty()) { %>
                    <tr><td class="empty-state" colspan="3">Nenhuma trilha disponível para exibir.</td></tr>
                <% } %>
                <% for (int i = 0; i < ranking.size(); i++) {
                    Trilha t = ranking.get(i);
                    String cssRanking = (i == 0 && t.getVotos() > 0) ? "class='primeiro-lugar'" : "";
                %>
                    <tr <%= cssRanking %>>
                        <td class="position-cell"><span class="position-number"><%= i + 1 %></span></td>
                        <td><span class="track-name"><%= t.getNome() %></span></td>
                        <td class="votes-cell"><span class="votos-badge"><%= t.getVotos() %></span></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
            </div>
        </section>

        <nav class="footer-nav" aria-label="Navegação entre páginas">
            <a class="page-button" href="inicio.jsp">ℹ️ Conheça as trilhas</a>
            <a class="page-button primary" href="index.jsp?votar=1">🗳️ Votação</a>
            <a class="page-button" href="resultado.jsp" aria-current="page">🏆 Ranking</a>
            <a class="page-button" href="resultado-graficos.jsp">📈 Gráficos e porcentagens</a>
        </nav>
    </div>
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
