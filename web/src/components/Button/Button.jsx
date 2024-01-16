// STYLES
import "./Button.css";

// eslint-disable-next-line react/prop-types
const Button = ({title, setActive = false}) => {
    return (
        <button type="button" className="cp-button" style={{color: setActive ? "rgb(0, 255, 0)" : "white"}}><span className="cp-button-text">{title}</span></button>
    );
};

export default Button;