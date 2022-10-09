$(document).ready(function(){
        $('#user_data_cpf').mask('000.000.000-00', { plaeholder: '___.___.___-__'});
        $('#user_data_cnpj').mask('00.000.000/0000-00', { plaeholder: '__.___.___/____-__'});
        $('#professional_postal_code').mask('00000-000', { placeholder: '_____-___' });
        $('#company_postal_code').mask('00000-000', { placeholder: '_____-___' });
});
