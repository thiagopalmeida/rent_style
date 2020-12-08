const ajustForm = () => {
  const formItem = document.getElementById('product_category');
  console.log(formItem);
  const sapato = document.getElementById('product_size');
  console.log(sapato);
  const roupa = document.getElementById('product');
  console.log(roupa);

  if (formItem.value === "Sapato Masculino" || formItem.value === "Sapato Feminino") {
    formItem.addEventListener ('change', () => {
      sapato.show();
      roupa.hide();
    })
  }
  else {
      formItem.addEventListener ('change', () => {
      sapato.hide();
      roupa.show();
    })
  }
}

export { ajustForm };


