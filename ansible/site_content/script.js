document.addEventListener('DOMContentLoaded', () => {
    const learnMoreBtn = document.getElementById('learnMoreBtn');
    const aiApplications = document.getElementById('aiApplications');
    const askQuestionBtn = document.getElementById('askQuestionBtn');
    const aiQuestionInput = document.getElementById('aiQuestion');
    const aiAnswer = document.getElementById('aiAnswer');

    if (learnMoreBtn) {
        learnMoreBtn.addEventListener('click', () => {
            if (aiApplications.style.display === 'none') {
                aiApplications.style.display = 'block';
                learnMoreBtn.textContent = 'Свернуть';
            } else {
                aiApplications.style.display = 'none';
                learnMoreBtn.textContent = 'Узнать больше о применении ИИ';
            }
        });
    }

    if (askQuestionBtn) {
        askQuestionBtn.addEventListener('click', () => {
            const question = aiQuestionInput.value.trim();
            if (question) {
                const responses = [
                    "ИИ очень быстро развивается, и его потенциал огромен!",
                    "Ключевые области ИИ включают машинное обучение и глубокое обучение.",
                    "Этические вопросы ИИ являются важной темой для обсуждения.",
                    "ИИ уже используется во многих повседневных приложениях.",
                    "Будущее ИИ обещает быть захватывающим и полным перемен."
                ];
                const randomResponse = responses[Math.floor(Math.random() * responses.length)];
                aiAnswer.textContent = `Ваш вопрос: "${question}". Ответ ИИ: "${randomResponse}"`;
                aiQuestionInput.value = ''; 
            } else {
                aiAnswer.textContent = "Пожалуйста, введите ваш вопрос.";
            }
        });
    }
});
