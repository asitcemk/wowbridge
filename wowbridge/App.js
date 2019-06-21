import React from 'react';
import parse from 'html-react-parser';
import logo from './logo.svg';
import './App.css';

function App() {
  let html="<ul>";
    html+="<li ><a  >Action</a></li>"
    html+="<li ><a  >Another action</a></li>"
    html+="<li ><a  >Something else here</a></li>"
    html+="<li ><a >Separated link</a></li>"
  html+="</ul>";
  let str="<h2>Essential things to think about before starting a blog</h2>";
  str+="<p>It has been exactly 3 years since I wrote my first blog series entitled &ldquo;Flavorful Tuscany&rdquo;, but starting it was definitely not easy. Back then, I didn&rsquo;t know much about blogging, let alone think that one day it could become <strong>my full-time job</strong>. Even though I had many recipes and food-related stories to tell, it never crossed my mind that I could be sharing them with the whole world</p>";
  str+="<p>I am now a <strong>full-time blogger</strong> and the curator of the <a href='https://ckeditor.com/ckeditor-4/#'>Simply delicious newsletter</a>, sharing stories about traveling and cooking, as well as tips on how to run a successful blog.</p>";
  str+="<p>If you are tempted by the idea of creating your own blog, please think about the following:</p>";
 str+="<h1 style='color:blue;'>This is a Blue Heading</h1>";
str+="<ul>";
 str+=" <li>Your story (what do you want to tell your audience)</li>";
  str+="<li>Your audience (who do you write for)</li>";
  str+="<li>Your blog name and design</li>";
str+="</ul>";

str+="<p>After you get your head around these 3 essentials, all you have to do is grab your keyboard and the rest will follow.</p>";

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
      <div className="holder">
      <div className="edit" contentEditable={true} suppressContentEditableWarning={true}>
    {parse(str)}
    <b style={{color:"blue"}} contentEditable={false}>input</b>
    {parse(html)}
    </div>
          <div dangerouslySetInnerHTML={{__html: html}}></div>
      </div>
      <h1>ASIT</h1>
    </div>
  );
}

export default App;
