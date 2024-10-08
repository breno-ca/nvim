var content = document.createElement('div')
content.setAttribute('id', 'content')
content.style.cssText = `
  color: red;
  background-color: blue;
`

content.innerHTML = `
<div>   </div>
`


document.body.appendChild(content)



//(assignment_expression 
//  right: (template_string
//
//    (string_fragment) @capture))
