import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/// State of the comments sheet for a single post.
class CommentsController extends GetxController {
  CommentsController(this.post);

  final PostModel post;

  final textController = TextEditingController();
  final focusNode = FocusNode();
  final scrollController = ScrollController();

  static const List<String> quickEmojis = [
    '😀', '😂', '😍', '🔥', '👏', '🙌', '👍', '🎉', '😮', '🏔️', '🌲', '❤️',
  ];

  final hasText = false.obs;
  final showEmojis = false.obs;
  final attachedImage = Rxn<String>();

  /// Thread the next reply is added to, and the person being answered.
  final replyThread = Rxn<CommentModel>();
  final replyTarget = Rxn<CommentModel>();

  final ImagePicker _picker = ImagePicker();
  int _nextId = 0;

  bool get canSend => hasText.value || attachedImage.value != null;

  @override
  void onInit() {
    super.onInit();
    textController.addListener(
      () => hasText.value = textController.text.trim().isNotEmpty,
    );
  }

  void react(Reactable item, Reaction reaction) =>
      Get.find<HomeController>().react(item, reaction);

  void toggleExpanded(CommentModel comment) => comment.isExpanded.toggle();

  void startReply(CommentModel thread, CommentModel target) {
    replyThread.value = thread;
    replyTarget.value = target;
    showEmojis.value = false;
    focusNode.requestFocus();
  }

  void cancelReply() {
    replyThread.value = null;
    replyTarget.value = null;
  }

  void toggleEmojis() => showEmojis.toggle();

  void insertEmoji(String emoji) {
    final value = textController.value;
    final selection = value.selection;
    final start = selection.isValid ? selection.start : value.text.length;
    final end = selection.isValid ? selection.end : value.text.length;
    final text = value.text.replaceRange(start, end, emoji);
    textController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: start + emoji.length),
    );
  }

  Future<void> pickImage() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      imageQuality: 85,
    );
    if (file != null) attachedImage.value = file.path;
  }

  void removeImage() => attachedImage.value = null;

  void send() {
    if (!canSend) return;

    final thread = replyThread.value;
    final target = replyTarget.value;
    var text = textController.text.trim();
    if (thread != null && target != null && target != thread) {
      text = '@${target.author} $text';
    }

    final comment = CommentModel(
      id: '${post.id}_new_${_nextId++}',
      author: AppText.you,
      avatar: ImagePath.avatarWilliam,
      text: text,
      timeAgo: AppText.justNow,
      imagePath: attachedImage.value,
    );

    if (thread != null) {
      thread.replies.add(comment);
    } else {
      post.comments.add(comment);
      _scrollToEnd();
    }
    post.addedComments.value++;

    textController.clear();
    attachedImage.value = null;
    showEmojis.value = false;
    cancelReply();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void onClose() {
    textController.dispose();
    focusNode.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
