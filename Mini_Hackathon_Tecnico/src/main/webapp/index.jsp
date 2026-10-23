<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.senai.service.TrilhaService" %>
<%@ page import="com.senai.model.Trilha" %>
<%@ page import="java.util.List" %>
<%
    if ("GET".equalsIgnoreCase(request.getMethod()) && request.getParameter("votar") == null) {
        response.sendRedirect("inicio.jsp");
        return;
    }

    TrilhaService service = TrilhaService.getInstance();
    String alertSucesso = null;
    String alertErro = null;

    String idParam = request.getParameter("id");

    if (idParam != null) {
        try {
            int id = Integer.parseInt(idParam);

            boolean valido = service.registrarVoto(id);

            if (valido) {
                alertSucesso = "Voto computado com sucesso! Próximo da fila já pode votar.";
            } else {
                alertErro = "Código de trilha inválido.";
            }
        } catch (NumberFormatException e) {
            alertErro = "Código de trilha inválido.";
        }
    }

    List<Trilha> lista = service.getTrilhas();
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mundo SENAI - Termômetro de Tecnologias</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Segoe UI', Helvetica, Arial, sans-serif; background-color: #F4F7FA; margin: 0; padding: 20px; color: #2D3748; }
        .container { max-width: 550px; background: #FFFFFF; margin: 40px auto; padding: 35px; border-radius: 8px; box-shadow: 0 10px 25px rgba(0, 92, 169, 0.08); border-top: 6px solid #005CA9; }
        .theme-options { display: flex; justify-content: center; gap: 8px; margin-bottom: 24px; }
        .theme-button { min-width: 104px; padding: 10px 16px; color: #005CA9; background: #FFFFFF; border: 1px solid #B9CCDD; border-radius: 8px; cursor: pointer; font-size: 14px; font-weight: 700; transition: background .2s, color .2s, border-color .2s; }
        .theme-button:hover { background: #F1F7FC; border-color: #005CA9; }
        .theme-button[aria-pressed="true"] { color: #FFFFFF; background: #005CA9; border-color: #005CA9; }
        .theme-button:focus-visible { outline: 3px solid #63B3ED; outline-offset: 3px; }
        .header-logo { text-transform: uppercase; font-weight: 900; letter-spacing: 1px; color: #005CA9; font-size: 24px; margin-bottom: 5px; text-align: center; }
        .subtitle { text-align: center; color: #718096; font-size: 14px; margin-bottom: 30px; }

        .msg { padding: 15px; margin-bottom: 20px; border-radius: 6px; font-weight: 600; font-size: 14px; border-left: 4px solid; text-align: left; }
        .sucesso { background: #E6FFFA; color: #014D40; border-left-color: #319795; }
        .erro { background: #FFF5F5; color: #9B2C2C; border-left-color: #E53E3E; }

        .card { background: #FFFFFF; border: 1px solid #E2E8F0; padding: 18px; margin-bottom: 12px; border-radius: 6px; display: flex; justify-content: space-between; align-items: center; text-align: left; transition: all 0.2s; }
        .card:hover { border-color: #CBD5E0; transform: translateY(-1px); }
        .trilha-title { color: #005CA9; font-size: 16px; font-weight: 700; }
        .trilha-desc { font-size: 13px; color: #4A5568; margin-top: 4px; line-height: 1.4; }

        .btn { background: #005CA9; color: #FFFFFF; border: none; padding: 10px 18px; border-radius: 4px; cursor: pointer; font-weight: 700; font-size: 12px; text-transform: uppercase; letter-spacing: 0.5px; }
        .btn:hover { background: #004480; }

        .footer-nav { display: flex; flex-wrap: wrap; justify-content: center; gap: 10px; margin-top: 25px; border-top: 1px solid #E2E8F0; padding-top: 20px; }
        .page-button { display: inline-flex; align-items: center; justify-content: center; min-height: 44px; padding: 10px 16px; color: #005CA9; background: #FFFFFF; border: 1px solid #B9CCDD; border-radius: 8px; text-decoration: none; font-size: 13px; font-weight: 700; transition: background .2s, color .2s, border-color .2s, transform .2s; }
        .page-button:hover { background: #F1F7FC; border-color: #005CA9; transform: translateY(-1px); }
        .page-button.primary { color: #FFFFFF; background: #005CA9; border-color: #005CA9; }
        .page-button.primary:hover { background: #004480; border-color: #004480; }
        .page-button[aria-current="page"] { color: #526477; background: #EDF2F7; border-color: #D6E1EC; cursor: default; }
        .page-button:focus-visible { outline: 3px solid #63B3ED; outline-offset: 3px; }

        html.dark-mode { color-scheme: dark; }
        html.dark-mode body { background-color: #1A202C; color: #E2E8F0; }
        html.dark-mode .container { background: #2D3748; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.25); }
        html.dark-mode .theme-button { color: #90CDF4; background: #1D2733; border-color: #526174; }
        html.dark-mode .theme-button:hover { background: #344154; border-color: #90CDF4; }
        html.dark-mode .theme-button[aria-pressed="true"] { color: #14202B; background: #90CDF4; border-color: #90CDF4; }
        html.dark-mode .header-logo, html.dark-mode .trilha-title { color: #63B3ED; }
        html.dark-mode .subtitle, html.dark-mode .trilha-desc { color: #B0BDCA; }
        html.dark-mode .card { background: #1D2733; border-color: #3A4655; }
        html.dark-mode .card:hover { border-color: #5D8FB7; }
        html.dark-mode .footer-nav { border-top-color: #3A4655; }
        html.dark-mode .page-button { color: #90CDF4; background: #1D2733; border-color: #526174; }
        html.dark-mode .page-button:hover { background: #344154; border-color: #90CDF4; }
        html.dark-mode .page-button.primary { color: #14202B; background: #90CDF4; border-color: #90CDF4; }
        html.dark-mode .page-button.primary:hover { background: #63B3ED; }
        html.dark-mode .page-button[aria-current="page"] { color: #B0BDCA; background: #354354; border-color: #526174; }
        html.dark-mode .sucesso { background: #1D4642; color: #B2F5EA; border-left-color: #38B2AC; }
        html.dark-mode .erro { background: #512D32; color: #FED7D7; border-left-color: #FC8181; }
        @media (max-width: 600px) {
            body { padding: 14px 12px; }
            .container { margin: 18px auto; padding: 24px 18px; }
            .card { gap: 12px; }
            .btn { padding: 10px 12px; }
        }
        @media (max-width: 380px) {
            .card { align-items: flex-start; flex-direction: column; }
            .card form, .btn { width: 100%; }
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

    <% if (alertSucesso != null) { %>
    <script>
        setTimeout(function() {
            window.location.href = "index.jsp?votar=1";
        }, 3000);
    </script>
    <% } %>
</head>
<body>
    <div class="container">
        <div class="theme-options" role="group" aria-label="Escolha do tema">
            <button type="button" class="theme-button" id="light-theme" aria-pressed="true">☀ Claro</button>
            <button type="button" class="theme-button" id="dark-theme" aria-pressed="false">☾ Escuro</button>
        </div>
        <div class="header-logo">SENAI</div>
        <p class="subtitle">Termômetro de Tecnologias • Escolha a sua Trilha Profissional</p>

        <% if (alertSucesso != null) { %>
            <div class="msg sucesso">✓ <%= alertSucesso %></div>
        <% } %>

        <% if (alertErro != null) { %>
            <div class="msg erro">⚠️ <%= alertErro %></div>
        <% } %>

        <div class="lista-trilhas">
            <% if (lista.isEmpty()) { %>
                <p style="text-align: center; color: red; font-weight: bold;">Nenhuma trilha carregada no repositório.</p>
            <% } else { %>
                <%-- Laço de repetição que gera os cartões dinamicamente --%>
                <% for (Trilha t : lista) { %>
                    <div class="card" id="trilha-<%= t.getId() %>">
                        <div style="max-width: 70%;">
                            <div class="trilha-title"><%= t.getNome() %></div>
                            <div class="trilha-desc"><%= t.getDescricao() %></div>
                        </div>
                        <form method="POST" action="index.jsp?votar=1" style="margin: 0;">
                            <input type="hidden" name="id" value="<%= t.getId() %>">
                            <button type="submit" class="btn">Votar</button>
                        </form>
                    </div>
                <% } %>
            <% } %>
        </div>

        <nav class="footer-nav" aria-label="Navegação entre páginas">
            <a class="page-button" href="inicio.jsp">ℹ️ Conheça as trilhas</a>
            <a class="page-button" href="index.jsp?votar=1" aria-current="page">🗳️ Votação</a>
            <a class="page-button primary" href="resultado.jsp" target="_blank">🏆 Ranking de votos</a>
            <a class="page-button" href="resultado-graficos.jsp" target="_blank">📈 Gráficos e porcentagens</a>
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
