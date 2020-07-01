 class Usuario{
  int id;
  String nome;
  String email;
  String senha;
  String telefone;
  String cpf;
  String rg;
  String fotoPerfil;
  String comprovanteMatricula;
  String dtnascimento;
  String perfil;
  String cidade;
  String uf;
  String ativo;
  String instituicao;
  String curso;




  Usuario(this.nome,this.email, this.senha,this.telefone,this.cpf,this.rg,this.fotoPerfil,this.comprovanteMatricula,this.dtnascimento, this.perfil,this.cidade,this.uf,this.instituicao,this.curso, this.ativo);

Map<String,dynamic> toMap(){

  var map = <String,dynamic>{
    'id':id,
    'nome':nome,
    'email':email,
    'senha':senha,
    'telefone':telefone,
    'cpf':cpf,
    'rg':rg,
    'fotoPerfil': fotoPerfil,
    'comprovanteMatricula' : comprovanteMatricula,
    'dtnascimento':dtnascimento,
    'perfil':perfil,
    'ativo':ativo,
    'cidade': cidade,
    'uf' : uf,
    'instituicao' : instituicao,
    'curso' : curso
  };
  return map;
}

Usuario.fromMap(Map<String,dynamic> map){
  id = map['id'];
  nome = map['nome'];
  email = map['email'];
  senha = map['senha'];
  telefone = map['telefone'];
  cpf = map ['cpf'];
  rg = map ['rg'];
  fotoPerfil = map ['fotoPerfil'];
  comprovanteMatricula = map['comprovanteMatricula'];
  dtnascimento = map['dtnascimento'];
  perfil = map['perfil'];
  cidade =  map['cidade'];
  uf = map['uf'];
  ativo = map[ativo.toString()];
  instituicao = map['instituicao'];
  curso = map['curso'];
}

@override
  String toString() {

  return "Usuario => (id: $id, nome: $nome, email: $email, telefone: $telefone, cpf: $cpf, rg: $rg, dtnascimento: $dtnascimento, cidade: $cidade, uf: $uf, instituicao: $instituicao, curso: $curso)";
  }

}