import ReactDOM from 'react-dom/client';
import App from './App';
import './assets/main.css';
import { StrictMode } from 'react';
import { DndProvider } from 'react-dnd';
import { TouchBackend } from 'react-dnd-touch-backend';

// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
ReactDOM.createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <DndProvider backend={TouchBackend} options={{ enableMouseEvents: true }}>
            <App />
        </DndProvider>
    </StrictMode>,
);
