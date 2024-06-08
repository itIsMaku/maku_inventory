import ReactDOM from 'react-dom/client';
import App from './App';
import './assets/main.css';
import { VisibilityProvider } from './providers/VisibilityProvider';
import { StrictMode } from 'react';

// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
ReactDOM.createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <VisibilityProvider>
            <App />
        </VisibilityProvider>
    </StrictMode>,
);
