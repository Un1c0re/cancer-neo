import React from 'react';
import style from './LoadButton.module.css';

interface FetchButtonProps {
  children: string;
  className?: string;
  onClick: () => Promise<void>;
}

const FetchButton: React.FC<FetchButtonProps> = ({ children, className, onClick }) => {
  return (
    <button className={style.button} onClick={onClick}>
      {children}
    </button>
  );
};

export default FetchButton;
