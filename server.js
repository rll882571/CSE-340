// ==========================================
// 1. IMPORTAÇÕES E CONFIGURAÇÕES INICIAIS
// ==========================================
import express from 'express';
import { fileURLToPath } from 'url';
import path from 'path';
import { testConnection } from './src/models/db.js';
import router from './src/routes.js';

const NODE_ENV = process.env.NODE_ENV?.toLowerCase() || 'production';
const PORT = process.env.PORT || 3000;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

// ==========================================
// 2. CONFIGURAÇÃO DE VIEWS E ARQUIVOS ESTÁTICOS
// ==========================================
app.use(express.static(path.join(__dirname, 'public')));

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'src/views'));

// ==========================================
// 3. MIDDLEWARES GLOBAIS
// ==========================================
// Middleware 1: Registo de pedidos (logging)
app.use((req, res, next) => {
  if (NODE_ENV === 'development') {
    console.log(`${req.method} ${req.url}`);
  }
  next();
});

// Middleware 2: Variáveis globais para as views
app.use((req, res, next) => {
  res.locals.NODE_ENV = NODE_ENV;
  next();
});

// ==========================================
// 4. ROTAS DA APLICAÇÃO (CONTROLLERS ATUAIS)
// ==========================================
app.use(router);

// ==========================================
// 5. TRATAMENTO DE ERROS (404 E 500)
// ==========================================
// Rota catch-all para apanhar páginas não encontradas (Passo 3 da atividade)
app.use((req, res, next) => {
  const err = new Error('Page Not Found');
  err.status = 404;
  next(err);
});

// Middleware de tratamento de erros global
app.use((err, req, res, next) => {
  console.error('Error occurred:', err.message);
  console.error('Stack trace:', err.stack);

  const status = err.status || 500;
  const template = status === 404 ? '404' : '500';

  const context = {
    title: status === 404 ? 'Page Not Found' : 'Server Error',
    error: err.message,
    stack: err.stack
  };

  res.status(status).render(`errors/${template}`, context);
});

// ==========================================
// 6. INICIALIZAÇÃO DO SERVIDOR
// ==========================================
app.listen(PORT, async () => {
  try {
    await testConnection();
    console.log(`Server is running at http://127.0.0.1:${PORT}`);
    console.log(`Environment: ${NODE_ENV}`);
  } catch (error) {
    console.error('Error connecting to the database:', error.message);
  }
});