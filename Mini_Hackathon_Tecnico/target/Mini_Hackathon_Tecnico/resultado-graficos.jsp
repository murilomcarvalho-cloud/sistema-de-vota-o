<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.senai.service.TrilhaService" %>
<%@ page import="com.senai.model.Trilha" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Locale" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    List<Trilha> trilhas = new ArrayList<>(TrilhaService.getInstance().getTrilhas());
    int totalVotos = 0;
    for (Trilha trilha : trilhas) {
        totalVotos += trilha.getVotos();
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="refresh" content="3">
    <title>Mundo SENAI - Resultados em Gráficos</title>
    <style>
        :root { font-family: 'Segoe UI', Arial, sans-serif; color: #243447; background: #F2F6FB; }
        * { box-sizing: border-box; }
        body { min-height: 100vh; margin: 0; padding: 32px 20px; background: radial-gradient(ellipse at top, #E4F1FC 0, #F2F6FB 54%, #F7F9FC 100%); }
        .container { max-width: 900px; margin: 0 auto; padding: 28px 38px 24px; background: #FFFFFF; border: 1px solid #E5ECF3; border-top: 5px solid #005CA9; border-radius: 16px; box-shadow: 0 18px 55px rgba(25, 60, 95, .10); }
        .topbar { display: flex; justify-content: center; align-items: center; gap: 12px; margin-bottom: 24px; }
        .theme-label { color: #526477; font-size: 13px; font-weight: 700; }
        .theme-options { display: inline-flex; gap: 8px; }
        .theme-button { min-width: 100px; padding: 10px 16px; color: #005CA9; background: #FFFFFF; border: 1px solid #B9CCDD; border-radius: 8px; cursor: pointer; font-size: 14px; font-weight: 700; transition: background .2s, color .2s, border-color .2s; }
        .theme-button:hover { background: #F1F7FC; border-color: #005CA9; }
        .theme-button[aria-pressed="true"] { color: #FFFFFF; background: #005CA9; border-color: #005CA9; }
        .hero { margin-bottom: 28px; text-align: center; }
        .header-logo { display: inline-flex; align-items: center; justify-content: center; min-width: 82px; padding: 8px 15px; color: #FFFFFF; background: #005CA9; border-radius: 7px; font-size: 18px; font-weight: 900; letter-spacing: 1.5px; }
        .eyebrow { margin: 20px 0 8px; color: #005CA9; font-size: 11px; font-weight: 800; letter-spacing: 1.8px; text-transform: uppercase; }
        h1 { margin: 0; color: #19324A; font-size: clamp(27px, 4vw, 35px); line-height: 1.2; letter-spacing: -.7px; }
        .subtitle { max-width: 520px; margin: 12px auto 17px; color: #66788A; font-size: 15px; line-height: 1.6; }
        .live-status { display: inline-flex; align-items: center; gap: 8px; padding: 7px 11px; color: #27745A; background: #E8F8F0; border: 1px solid #C8EBDD; border-radius: 999px; font-size: 11px; font-weight: 700; }
        .live-dot { width: 7px; height: 7px; background: #36A879; border-radius: 50%; box-shadow: 0 0 0 3px rgba(54, 168, 121, .13); }
        .summary { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 14px; margin-bottom: 24px; }
        .summary-card { padding: 18px 20px; background: #F7FAFD; border: 1px solid #E5ECF3; border-radius: 11px; }
        .summary-label { display: block; margin-bottom: 8px; color: #718096; font-size: 11px; font-weight: 800; letter-spacing: .8px; text-transform: uppercase; }
        .summary-value { color: #19324A; font-size: 25px; font-weight: 800; line-height: 1.15; }
        .summary-note { display: block; margin-top: 5px; color: #718096; font-size: 12px; }
        .chart-panel { padding: 22px; border: 1px solid #E4EAF0; border-radius: 12px; }
        .chart-heading { display: flex; justify-content: space-between; align-items: baseline; gap: 12px; margin-bottom: 20px; }
        .chart-heading h2 { margin: 0; color: #243447; font-size: 17px; }
        .chart-heading span { color: #718096; font-size: 12px; }
        .chart-list { display: grid; gap: 18px; }
        .chart-row { display: grid; grid-template-columns: minmax(130px, 1fr) minmax(140px, 2fr) 64px; align-items: center; gap: 14px; }
        .chart-name { overflow: hidden; color: #2C4054; font-size: 13px; font-weight: 700; text-overflow: ellipsis; white-space: nowrap; }
        .bar-track { height: 14px; overflow: hidden; background: #EDF2F7; border-radius: 999px; }
        .bar-fill { height: 100%; min-width: 0; background: linear-gradient(90deg, #0075C9, #42A5E8); border-radius: inherit; transition: width .5s ease; }
        .chart-row:first-child .bar-fill { background: linear-gradient(90deg, #005CA9, #D6A52A); }
        .chart-value { color: #40566C; font-size: 13px; font-weight: 800; text-align: right; }
        .empty-state { padding: 28px 16px; color: #718096; background: #F7FAFD; border-radius: 9px; text-align: center; }
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
        html.dark-mode .header-logo { background: #1A6DB1; }
        html.dark-mode .eyebrow { color: #7CC4F4; }
        html.dark-mode h1, html.dark-mode .chart-heading h2, html.dark-mode .summary-value { color: #F0F5FA; }
        html.dark-mode .subtitle, html.dark-mode .chart-heading span, html.dark-mode .summary-label, html.dark-mode .summary-note { color: #B0BDCA; }
        html.dark-mode .theme-label { color: #B0BDCA; }
        html.dark-mode .theme-button { color: #90CDF4; background: #1D2733; border-color: #526174; }
        html.dark-mode .theme-button:hover { background: #344154; border-color: #90CDF4; }
        html.dark-mode .theme-button[aria-pressed="true"] { color: #14202B; background: #90CDF4; border-color: #90CDF4; }
        html.dark-mode .live-status { color: #9AE6C5; background: #1D4642; border-color: #28655D; }
        html.dark-mode .live-dot { background: #57C798; }
        html.dark-mode .summary-card, html.dark-mode .chart-panel { background: #1D2733; border-color: #3A4655; }
        html.dark-mode .chart-name { color: #E2E8F0; }
        html.dark-mode .bar-track { background: #354354; }
        html.dark-mode .bar-fill { background: linear-gradient(90deg, #1A6DB1, #63B3ED); }
        html.dark-mode .chart-row:first-child .bar-fill { background: linear-gradient(90deg, #1A6DB1, #D6A52A); }
        html.dark-mode .chart-value { color: #D6E0EA; }
        html.dark-mode .empty-state { color: #B0BDCA; background: #1D2733; }
        html.dark-mode .footer-nav { border-top-color: #3A4655; }
        html.dark-mode .page-button { color: #90CDF4; background: #1D2733; border-color: #526174; }
        html.dark-mode .page-button:hover { background: #344154; border-color: #90CDF4; }
        html.dark-mode .page-button.primary { color: #14202B; background: #90CDF4; border-color: #90CDF4; }
        html.dark-mode .page-button.primary:hover { background: #63B3ED; }
        html.dark-mode .page-button[aria-current="page"] { color: #B0BDCA; background: #354354; border-color: #526174; }
        @media (max-width: 600px) {
            body { padding: 14px 12px; }
            .container { padding: 20px 17px 18px; border-radius: 13px; }
            .summary { gap: 9px; }
            .summary-card { padding: 14px; }
            .summary-value { font-size: 21px; }
            .chart-panel { padding: 17px 14px; }
            .chart-row { grid-template-columns: minmax(90px, .9fr) minmax(70px, 1.3fr) 52px; gap: 9px; }
            .chart-name, .chart-value { font-size: 12px; }
        }
        @media (max-width: 380px) {
            .chart-row { grid-template-columns: 1fr 50px; gap: 7px; }
            .chart-name { grid-column: 1 / -1; }
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
            <h1>Resultados em porcentagem</h1>
            <p class="subtitle">Veja como os votos estão distribuídos entre as trilhas profissionais.</p>
            <span class="live-status"><span class="live-dot" aria-hidden="true"></span>Atualização automática</span>
        </header>

        <section class="summary" aria-label="Resumo dos votos">
            <div class="summary-card">
                <span class="summary-label">Total de votos</span>
                <span class="summary-value"><%= totalVotos %></span>
                <span class="summary-note">votos computados</span>
            </div>
            <div class="summary-card">
                <span class="summary-label">Trilhas disponíveis</span>
                <span class="summary-value"><%= trilhas.size() %></span>
                <span class="summary-note">opções de votação</span>
            </div>
        </section>

        <section class="chart-panel" aria-labelledby="chart-title">
            <div class="chart-heading">
                <h2 id="chart-title">Distribuição dos votos</h2>
                <span>Percentual por trilha</span>
            </div>
            <% if (trilhas.isEmpty()) { %>
                <div class="empty-state">Nenhuma trilha disponível para exibir.</div>
            <% } else if (totalVotos == 0) { %>
                <div class="empty-state">Ainda não há votos. Os gráficos serão preenchidos conforme as pessoas votarem.</div>
            <% } else { %>
                <div class="chart-list">
                    <% for (Trilha trilha : trilhas) {
                        double percentual = totalVotos > 0 ? (trilha.getVotos() * 100.0) / totalVotos : 0;
                    %>
                        <div class="chart-row">
                            <span class="chart-name" title="<%= trilha.getNome() %>"><%= trilha.getNome() %></span>
                            <div class="bar-track" role="img" aria-label="<%= trilha.getNome() %>: <%= String.format(Locale.forLanguageTag("pt-BR"), "%.1f", percentual) %> por cento dos votos">
                                <div class="bar-fill" style="width: <%= String.format(Locale.US, "%.2f", percentual) %>%;"></div>
                            </div>
                            <span class="chart-value"><%= String.format(Locale.forLanguageTag("pt-BR"), "%.1f", percentual) %>%</span>
                        </div>
                    <% } %>
                </div>
            <% } %>
        </section>

        <nav class="footer-nav" aria-label="Navegação dos resultados">
            <a class="page-button" href="inicio.jsp">ℹ️ Conheça as trilhas</a>
            <a class="page-button primary" href="index.jsp?votar=1">🗳️ Votação</a>
            <a class="page-button" href="resultado.jsp">🏆 Ranking</a>
            <a class="page-button" href="resultado-graficos.jsp" aria-current="page">📈 Gráficos e porcentagens</a>
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
