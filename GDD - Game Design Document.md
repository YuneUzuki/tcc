# Proposta e Escopo
--- 
Este jogo se trata de um RPG de Turno, com um escopo extremamente pequeno, basicamente um protótipo, criado com a intenção de testar a engine Godot e definir a viabilidade do desenvolvimento de um jogo do gênero na mesma.

Como mencionado, o escopo do jogo é pequeno, se trata de apenas uma batalha em turno, com 3 personagens jogáveis e 3 inimigos. O jogo terá um estado de falha e um estado de vitória, dependendo de qual dos lados tiver todos os seus personagens finalizados primeiro.

# Mecânicas
---
## Estatísticas
### O quê?
Cada *entidade* - personagem jogável ou personagem do inimigo - possui uma combinação de 3 estatísticas - **Ataque, Defesa e Saúde** - as quais definem a efetividade desta entidade em certas situações:
**Ataque**: Define a quantidade de dano que uma entidade dá em seu alvo ao executar uma ação ofensiva, como Atacar ou Magia. Quanto mais Ataque uma entidade possuir, maior o dano.
**Defesa**: Reduz o dano que a entidade recebe quando outra entidade executa uma ação ofensiva na mesma. Quanto maior a Defesa, menor o dano recebido.
**Saúde**: Define a quantidade de dano que a entidade pode tomar antes de ser marcada como finalizada, incapacitando a mesma pelo resto da batalha.
### Por quê?
Estatísticas são uma mecânica extremamente comum no gênero e se provam necessárias para distinguir personagens e inimigos, e criar uma função para o mesmo. Por exemplo, um personagem com maior defesa e saúde pode ser usado como um "escudo" para os outros personagens. Isso cria um nível de estratégia no jogo que o gênero é conhecido por ter, e cria desafio no jogo, incentivando o jogador a se adaptar a situações diferentes, considerando as estatísticas de seus personagens e dos inimigos que o mesmo precisará lutar contra.
### Como?
Para a implementação desta mecânica, será feito uso de classes, e para facilitar o desenvolvimento, será utilizado a funcionalidade @export da linguagem GDScript. Será criada uma classe **Entidade**, a qual irá incluir estas três estatísticas como variáveis, com uma variável para Ataque, uma para Defesa e duas para Saúde. A estatística de saúde precisa de duas variáveis pois precisamos manter a quantidade de Saúde máxima de um personagem, o valor que o mesmo inicia o combate e que o mesmo não pode passar, e também a Saúde atual do mesmo, tendo em vista que entidades irão perder Saúde e vão ser curados durante a batalha, constantemente alterando a Saúde atual, mas mantendo a saúde máxima fixa.

## Ações
### O quê?
Se tratam das ações que cada entidade consegue executar durante combate. Todas as entidades possuem 3 ações, duas universais e uma única para cada entidade. As ações universais são Atacar e Defender. Segue uma lista descrevendo cada ação:
**Atacar**: Uma ação que usa a estatística de Ataque para atacar um oponente. O alvo é definido de forma aleatória, e o dano desta ação também depende da Defesa do alvo.
**Defender**: Esta ação aumenta a defesa da entidade quando utilizada, de forma temporária, expirando no próximo turno desta entidade.
**Magia**: Uma ação única do personagem mago, se trata de um ataque que usa da estatística de Ataque do personagem, mas ignora a Defesa do oponente, sendo mais forte contra inimigos que possuem defesa alta.
**Curar**: Uma ação única do personagem curandeiro, esta ação restaura Saúde perdida ao personagem do jogador que possuir a menor Saúde atual quando esta ação for utilizada. A quantidade restaurada é aleatória, curando entre 20% a 40% relativo a Saúde máxima do personagem que for curado.
**Distrair**: Ação única do personagem cavalheiro, o qual distrai os inimigos até seu próximo turno, fazendo com que os mesmos não consigam atacar os outros personagens, focando apenas no cavalheiro.
**Ataque Carregado**: Ação única do inimigo morcego, a qual funciona igual a ação Atacar, mas possui um modificador que aumenta o dano do mesmo em 2x.
**Voar**: Ação única do inimigo Pom, o qual age como o oposto da ação distrair, fazendo com que nenhum ataque possa acertar o Pom até seu próximo turno.  