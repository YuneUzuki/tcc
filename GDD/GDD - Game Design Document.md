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
Para a implementação desta mecânica, será feito uso de classes, e para facilitar o desenvolvimento, será utilizado a funcionalidade @export da linguagem GDScript. Será criada uma classe *Entity*, a qual irá incluir estas três estatísticas como variáveis, com uma variável para Ataque, uma para Defesa e duas para Saúde. A estatística de saúde precisa de duas variáveis pois precisamos manter a quantidade de Saúde máxima de um personagem, o valor que o mesmo inicia o combate e que o mesmo não pode passar, e também a Saúde atual do mesmo, tendo em vista que entidades irão perder Saúde e vão ser curados durante a batalha, constantemente alterando a Saúde atual, mas mantendo a saúde máxima fixa.

A classe *Entity* também irá possuir uma variável do tipo bool com o nome isPlayable, que servirá para verificar se aquela entidade é jogável ou inimigo. Todas as entidades em combate serão um "objeto" (Nó) da classe *Entity*.

![[EntityClass.png]]

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

Ações são diretamente ligadas aos Turnos. Sempre que uma ação é executada, o turno da entidade se encerra, assim funcionando o combate. Entrarei em detalhes sobre turnos mais a frente.
### Por Quê?
Se tratam a mecânica principal do jogo, definem a interação entre as entidades. As ações únicas existem para criar uma diferença entre entidades e personagens, deixando cada um mais único que apenas uma diferença de estatísticas.
### Como?
Será feito uso da técnica de composição da engine. Essa técnica se refere a criação de nós customizados, com todo código da funcionalidade, nesse caso, código da ação, e depois que pronto, podemos usar para compor cada entidade. Por exemplo, como filhos do nó referente ao personagem Mago, podemos ter os nós Atacar, Defender e Magia, cada nó permitindo esta ação a esta entidade. Se adicionassemos, por exemplo, o nó da ação Voar ao personagem.

Todas as ações possuem algumas funções em comum, então cada ação será uma ação filha da classe *Action*, a qual irá lidar com as funcionalidades padrão que todas as ações precisam. Estas funcionalidades são relacionadas a avançar turnos e estado do jogo, isso será melhor descrito nos parágrafos referentes a estas funcionalidades.

## Turnos
### O quê?
Turnos são a base de um combate no gênero, é a estrutura que define o funcionamento. O meio em que turnos funcionam neste jogo é bem simplista. Ao começo da batalha, os turnos são definidos de forma aleatória, e entram em repetição dessa forma até o fim do jogo. Durante o turno de um personagem jogável, o jogador escolhe uma ação, enquanto, durante o turno de um personagem inimigo, uma ação é escolhida de forma aleatória, com certas regras para a escolha de ações. Após uma ação ser selecionada, o turno é encerrado e passado para o próximo na ordem definida. Caso a próxima entidade a ter um turno tenha sido derrubada, o turno da mesma é pulado.
### Por quê?
A explicação aqui é simples, turnos são a estrutura básica do combate em turno, então essa mecânica é praticamente obrigatória em um jogo que busca estudar a viabilidade do gênero na engine.
### Como?
Existem múltiplos passos para a definição de como os turnos serão implementados. De forma geral, será utilizado um Nó nomeado *Turn Manager*, este terá a função de gerenciar os turnos. No começo do jogo, o mesmo lê e gera uma lista de todas as entidades que estarão presentes em combate. Esta lista passa por um processo de aleatorização, gerando a ordem aleatória de turnos.

Para passar turnos, serão utilizados Signals, uma função da engine que serve como um tipo de "Mensagem". Signals podem ser criados e configurados via código para que uma função acione um Signal, e qualquer outro objeto da Engine pode ter em seu script uma função que é ativada por esse Signal, assim sendo, conseguimos ativar uma função em um nó específico quando um Signal enviado por outra função for identificado. O modo com que serão usados será, no script do Turn Manager, existirá uma função que lida com o avanço de turno, checkando se a próxima entidade está derrubada, se é um turno do inimigo ou de um personagem jogável, e alterando o status do menu dependendo do resultado, neste caso deixando o menu onde o jogador pode escolher uma ação ativo, caso seja um turno de um personagem do jogador, ou escondendo este menu caso seja um turno inimigo. Esta função receberá um Signal que todas as ações possuem, que é enviado pelas ações sempre que uma é finalizada.

## Estados de Vitória ou Falha
### O quê?
São os estados finais do jogo, que ocorrem quando um dos dois lados da batalha tem todos os seus personagens com a Saúde zerada. Caso a saúde de todos os inimigos esteja em 0, o jogador entra em estado de Vitória, caso contrário, estado de Falha. Caso entre em estado de falha, o jogador pode reiniciar o jogo e tentar denovo, enquanto estado de vitória mostra uma tela de vitória e encerra o jogo após 10 segundos desta tela aberta.
### Por quê?
Pois o jogo necessita de um estado final, assim como qualquer outro jogo, e neste caso o estado final demonstraria o final de uma batalha em um jogo RPG de Turno, onde, normalmente, a batalha teria uma tela de resultados e depois lhe colocaria de volta no mapa ou masmorra que estava explorando. No caso desse jogo, como o escopo se trata de apenas uma batalha, o jogo apenas encerra.
### Como?
A implementação será parecida com a implementação do avanço de turno, onde todas as Ações que dão dano em uma entidade irão possuir um Signal, este signal irá ativar uma função em um nó chamado *State Manager*, que servirá para verificar o estado do jogo como um todo, verificando quais personagens estão abatidos e se o jogo pode ser encerrado com um estado de falha, vitória, ou se pode seguir normalmente. Quando este nó definir um estado de vitória ou falha, o mesmo deleta o nó gerenciador de turnos para previnir um avanço de turnos, e o Signal que este recebe sempre ocorre antes do Signal referente a ações como um todo que avança os turnos.

Quando o State Manager definir que o jogador entrou em falha, e caso o jogador escolha tentar novamente, o mesmo irá recarregar a cena da batalha, efetivamente reiniciando o jogo.