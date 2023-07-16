import streamlit as st
from PIL import Image
st.set_page_config(layout="wide")   

logo_image = Image.open("../assets/afl1.png")
st.image(logo_image, use_column_width=True)




# Page title and description

st.title("SimpliFLow")
st.markdown("<h5>Generate, Audit, and Deploy Smart Contracts on the Flow Blockchain within seconds.</h5>", unsafe_allow_html=True)


# CTA buttons

st.markdown("<a href='/Chat' target='_blank'><button class='cta-button'>Try Now →</button></a>", unsafe_allow_html=True)

# Footer
st.markdown("---")
st.write("© 2023 SimpliFLow. All rights reserved.")

# Custom CSS for aesthetics
st.markdown(
    """
    <style>
    @import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap');

button{
  position: relative;
  height: 65px;
  width: 210px;
  margin: 8px 0;
  font-size: 23px;
  font-weight: 500;
  letter-spacing: 1px;  
  border-radius: 5px;
  border: 1px solid transparent;
  outline: none;
  cursor: pointer;
  background: transparent;
  overflow: hidden;
  transition: 0.6s;
}

button:last-child{
  color: #00ef8b;
  border-color: #00ef8b;
}
button:before, button:after{
  position: absolute;
  content: '';
  left: 0;
  top: 0;
  height: 100%;
  filter: blur(30px);
  opacity: 0.4;
  transition: 0.6s;
}
button:before{
  width: 60px;
  background: rgba(255,255,255,0.6);
  transform: translateX(-130px) skewX(-45deg);
}
button:after{
  width: 30px;
  background: rgba(255,255,255,0.6);
  transform: translateX(-130px) skewX(-45deg);
}
button:hover:before,
button:hover:after{
  opacity: 0.6;
  transform: translateX(320px) skewX(-45deg);
}
button:hover{
  color: black;
}
button:hover:last-child{
  background: #00ef8b;
}
    </style>
    """,
    unsafe_allow_html=True
)
