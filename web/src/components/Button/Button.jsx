// STYLES
import "./Button.css";

// eslint-disable-next-line react/prop-types
const Button = ({title, setActive = false}) => {
    return (
        <button type="button" className="cp-button" style={{color: setActive ? "var(--cp-green)" : "white", border: setActive ? "1px solid var(--cp-green)" : "1px solid white"}}>{title}</button>
    );
};

export default Button;