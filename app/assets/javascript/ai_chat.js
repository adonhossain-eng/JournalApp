function attachChatModal() {
  // Get the button and modal elements
  const modal = document.getElementById('ai-chat-modal');
  const openButton = document.getElementById('ai-chat-button');
  const closeButton = document.getElementById('close-modal');

  if (!modal || !openButton || !closeButton) {
    return; // Exit if elements are not found
  }

  console.log("AI Chat JS loaded");

  openButton.replaceWith(openButton.cloneNode(true));
  closeButton.replaceWith(closeButton.cloneNode(true));

  const button = document.getElementById('ai-chat-button');
  const closeModal = document.getElementById('close-modal');
  
  const messageContainer = document.getElementById('chat-messages');
  // Add an event listener to the button
  button.addEventListener('click', function() {
    // Show the modal
    modal.style.display = 'flex';
    console.log("AI Chat button clicked");
    const messageRecord = document.getElementById('chat-messages').children;
    const pastMessages = [];
    for (let i = 0; i < messageRecord.length; i++) {
      pastMessages.push(messageRecord[i].textContent);
    }
    if (pastMessages.length === 0) {
      generateAIResponse(messageContainer, createContextString());
    }
  });
  // Close the modal when the user clicks the close button
  closeModal.addEventListener('click', function() {
    modal.style.display = 'none';
  });

  // Close the modal when the user clicks outside of it
  window.addEventListener('click', function(event) {
    if (event.target === modal) {
      modal.style.display = 'none';
    }
  });

  // Handle AI chat functionality (e.g., sending messages, handling responses)
  const chatInput = document.getElementById('chat-input');
  const sendBtn = document.getElementById('send-btn');

  sendBtn.addEventListener('click', async function() {
    // Get user input from the textarea
    const userInput = chatInput.value.trim();
    if (userInput === "") return;

    // Display user message
    const userMessage = document.createElement('div');
    userMessage.className = 'user-message';
    userMessage.textContent = "You: " + userInput;
    messageContainer.appendChild(userMessage);
    chatInput.value = '';

    // Scroll to the bottom
    messageContainer.scrollTop = messageContainer.scrollHeight;

    // Set context for AI response
    const contextString = createContextString();
    console.log("Context for AI:", contextString);
    // Send the message to the AI and handle its response (e.g., update the modal)
    generateAIResponse(messageContainer, contextString);

    // Scroll to the bottom
    messageContainer.scrollTop = messageContainer.scrollHeight;
  });
};

function createContextString() {
  const messageRecord = document.getElementById('chat-messages').children;
  const pastMessages = [];
  for (let i = 0; i < messageRecord.length; i++) {
    pastMessages.push(messageRecord[i].textContent);
  }
  console.log("Previous messages:", pastMessages);
  const a = document.querySelectorAll('[name="item[tag]"]');
  let tagText = "";
  a.forEach(element => {
    if (element.checked) {
      tagText = element.value;
    }
  });
  var contextString = "You are a journaling assistant helping a user. This entry is a " + 
                        tagText + " journal entry. Here is their journal entry:\n" +
                        document.getElementById('journalEntry').textContent + "\n" +
                        "END OF ENTRY\nDo be concise in your responses.\n";
  if (pastMessages.length > 0) {
    contextString += "Here is the chat history so far:\n" + pastMessages.join("\n") + "\n";
  }
  else {
    switch(tagText) {
      case "Ideas":
        contextString += "Comment on their ideas and suggest improvements, asking thoughtful follow-up questions.";
        break;
      case "Reflection":
        contextString += "Provide deep reflections on their thoughts and feelings, encouraging further introspection.";
        break;
      default:
        contextString += "Offer general support and encouragement for their journaling practice.";
        break;
    }
  }
  return contextString;
}

async function generateAIResponse(messageContainer, context) {
  const tempMsg = document.createElement('div');
  tempMsg.className = 'ai-message';
  tempMsg.textContent = "AI is typing...";
  messageContainer.appendChild(tempMsg);
  messageContainer.scrollTop = messageContainer.scrollHeight;

  const response = await fetch('/ai_chat', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    body: JSON.stringify({ message: context })
  });

  const data = await response.json();
  tempMsg.textContent = "AI: " + data.response;
}

document.addEventListener('turbo:load', attachChatModal);