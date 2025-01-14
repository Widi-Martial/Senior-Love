// Retrieve all the members the user has chatted with
export async function getAllUserContacts(req, res) {
  // Get my id and check if i'm active
  const myId = parseInt(req.user.userId, 10);
  const me = await User.findByPk(myId);
  if (!me || me.status === 'pending' || me.status === 'banned') {
    return res.status(401).json({ blocked: true });
  }

  const myContacts = await User.findAll({
    include: [
      {
        model: User_message,
        as: 'received_messages',
        where: {
          [Op.or]: [
            { sender_id: myId }, // Messages envoyés
            { receiver_id: myId }, // Messages reçus
          ],
        },
        attributes: ['id', 'message', 'created_at', 'sender_id', 'receiver_id'],
        required: true, // Ici, on récupère uniquement les utilisateurs avec des messages
        include: [
          {
            model: User,
            as: 'sender',
            attributes: ['id', 'name', 'picture'],
          },
          {
            model: User,
            as: 'receiver',
            attributes: ['id', 'name', 'picture'],
          },
        ],
      },
    ],
    attributes: ['id', 'name', 'picture'],
    order: [['created_at', 'DESC']],
  });
  res.status(200).json(myContacts);
}
  

